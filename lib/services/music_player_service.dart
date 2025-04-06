import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:just_audio/just_audio.dart' show ProcessingState;
import '../models/music_track.dart';
import '../models/player_state.dart';
import './audio_player_adapter.dart';

/// 音楽プレーヤーのビジネスロジックとステート管理を行うサービス
class MusicPlayerService with ChangeNotifier {
  final AudioPlayerAdapter _audioAdapter;

  // プレーヤーの状態
  MusicTrack? _currentTrack;
  PlayerState _playerState = PlayerState.empty;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  double _volume = 1.0;
  RepeatMode _repeatMode = RepeatMode.off;

  // トラックのマップを保持
  final Map<String, MusicTrack> _tracks = {};
  List<String> _musicFiles = [];

  // プレイリスト再生用の変数を追加
  List<String> _currentPlaylistTracks = [];
  int _currentPlaylistIndex = -1;

  // getter for music files
  List<String> get musicFiles => _musicFiles;

  // ゲッター
  MusicTrack? get currentTrack => _currentTrack;
  PlayerState get playerState => _playerState;
  Duration get position => _position;
  Duration get duration => _duration;
  double get volume => _volume;
  RepeatMode get repeatMode => _repeatMode;

  // プレイリストの状態を取得するゲッター
  bool get hasPlaylist => _currentPlaylistTracks.isNotEmpty;
  int get currentPlaylistIndex => _currentPlaylistIndex;
  List<String> get currentPlaylistTracks =>
      List.unmodifiable(_currentPlaylistTracks);

  // 便利なゲッター
  bool get hasCurrentTrack =>
      _currentTrack != null; // hasTrack を hasCurrentTrack に変更
  bool get isPlaying => _playerState == PlayerState.playing;
  bool get isPaused => _playerState == PlayerState.paused;
  bool get isCompleted => _playerState == PlayerState.completed;
  bool get isEmpty => _playerState == PlayerState.empty;

  double get progress {
    if (_duration.inMilliseconds == 0) return 0.0;
    return _position.inMilliseconds / _duration.inMilliseconds;
  }

  MusicPlayerService({AudioPlayerAdapter? audioAdapter})
    : _audioAdapter = audioAdapter ?? AudioPlayerAdapter() {
    _initStreams();
  }

  void _initStreams() {
    // 再生状態の変化を監視
    _audioAdapter.playingStream.listen((isPlaying) {
      _updatePlayerState(isPlaying);
    });

    _audioAdapter.processingStateStream.listen((processingState) {
      _updateProcessingState(processingState);

      // 曲が完了したら次の曲を再生
      if (processingState == ProcessingState.completed) {
        playNextTrack();
      }
    });

    // 再生位置の変化を監視
    _audioAdapter.positionStream.listen((position) {
      _position = position;
      notifyListeners();
    });

    // 曲の長さの変化を監視
    _audioAdapter.durationStream.listen((duration) {
      if (duration != null) {
        _duration = duration;
        notifyListeners();
      }
    });
  }

  void _updatePlayerState(bool isPlaying) {
    if (_currentTrack == null) {
      _playerState = PlayerState.empty;
    } else if (isPlaying) {
      _playerState = PlayerState.playing;
    } else if (_playerState != PlayerState.completed) {
      _playerState = PlayerState.paused;
    }
    notifyListeners();
  }

  void _updateProcessingState(ProcessingState processingState) {
    if (_currentTrack == null) {
      _playerState = PlayerState.empty;
    } else if (processingState == ProcessingState.completed) {
      _playerState = PlayerState.completed;
    }
    notifyListeners();
  }

  /// 曲をセットする
  Future<void> setTrack(MusicTrack track) async {
    _currentTrack = track;
    _tracks[track.id] = track; // トラックをマップに追加
    await _audioAdapter.setUrl(track.url);
    _playerState = PlayerState.paused;
    notifyListeners();
  }

  /// 再生する
  Future<void> play() async {
    if (_currentTrack == null) return;
    await _audioAdapter.play();
  }

  /// 一時停止する
  Future<void> pause() async {
    await _audioAdapter.pause();
  }

  /// 停止する
  Future<void> stop() async {
    await _audioAdapter.stop();
    await _audioAdapter.seek(Duration.zero);
    notifyListeners();
  }

  /// クリアする（空の状態にする）
  Future<void> clear() async {
    await _audioAdapter.stop();
    _currentTrack = null;
    _position = Duration.zero;
    _duration = Duration.zero;
    _playerState = PlayerState.empty;
    notifyListeners();
  }

  /// 特定の位置にシークする
  Future<void> seekTo(Duration position) async {
    await _audioAdapter.seek(position);
  }

  /// 音量を設定する
  Future<void> setVolume(double volume) async {
    _volume = volume.clamp(0.0, 1.0);
    await _audioAdapter.setVolume(_volume);
    notifyListeners();
  }

  /// 繰り返しモードを設定する
  Future<void> setRepeatMode(RepeatMode mode) async {
    _repeatMode = mode;
    await _audioAdapter.setLoopMode(mode);
    notifyListeners();
  }

  // トラックをマップに追加するメソッド
  void addTrack(MusicTrack track) {
    _tracks[track.id] = track;
    notifyListeners();
  }

  // IDからトラックを取得するメソッド
  MusicTrack? getTrackById(String id) {
    return _tracks[id];
  }

  // すべてのトラックを取得
  List<MusicTrack> get allTracks => _tracks.values.toList();

  // トラックの存在確認
  bool hasTrack(String id) {
    return _tracks.containsKey(id);
  }

  // 音楽ファイルを読み込むメソッド
  Future<void> loadMusicFiles() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final files = Directory(directory.path).listSync(recursive: true);

      _musicFiles =
          files
              .where((file) => file.path.toLowerCase().endsWith('.mp3'))
              .map((file) => file.path)
              .toList();

      // 音楽ファイルからトラックを作成してマップに追加
      for (var filePath in _musicFiles) {
        final fileName = filePath.split('/').last.replaceAll('.mp3', '');
        final track = MusicTrack(
          id: filePath, // ファイルパスをIDとして使用
          title: fileName,
          artist: 'Unknown',
          album: 'Local Music',
          url: filePath,
        );
        _tracks[track.id] = track;
      }

      notifyListeners();
    } catch (e) {
      print('Error loading music files: $e');
    }
  }

  // プレイリストを再生するメソッド
  Future<void> playPlaylist(List<String> trackIds) async {
    if (trackIds.isEmpty) return;

    // プレイリストを設定
    _currentPlaylistTracks = List.from(trackIds);
    _currentPlaylistIndex = 0;

    // 最初の曲を再生
    final firstTrack = getTrackById(
      _currentPlaylistTracks[_currentPlaylistIndex],
    );
    if (firstTrack == null) {
      playNextTrack(); // 無効なトラックの場合は次へ
      return;
    }

    await setTrack(firstTrack);
    await play();
  }

  // 次の曲を再生 (playNextTrack に変更)
  Future<void> playNextTrack() async {
    if (!hasPlaylist) return;

    _currentPlaylistIndex++;

    // プレイリストの最後まで到達した場合
    if (_currentPlaylistIndex >= _currentPlaylistTracks.length) {
      _currentPlaylistIndex = -1;
      _currentPlaylistTracks = [];
      await clear();
      return;
    }

    // 次の曲を再生
    final nextTrack = getTrackById(
      _currentPlaylistTracks[_currentPlaylistIndex],
    );
    if (nextTrack == null) {
      playNextTrack(); // 無効なトラックの場合は次へ
      return;
    }

    await setTrack(nextTrack);
    await play();
  }

  // 前の曲を再生
  Future<void> playPreviousTrack() async {
    if (!hasPlaylist || _currentPlaylistIndex <= 0) return;

    _currentPlaylistIndex--;
    final previousTrack = getTrackById(
      _currentPlaylistTracks[_currentPlaylistIndex],
    );
    if (previousTrack == null) {
      playNextTrack(); // 無効なトラックの場合は次へ
      return;
    }

    await setTrack(previousTrack);
    await play();
  }

  // プレイリストをクリア
  void clearPlaylist() {
    _currentPlaylistTracks = [];
    _currentPlaylistIndex = -1;
  }

  @override
  void dispose() {
    clearPlaylist();
    _audioAdapter.dispose();
    super.dispose();
  }
}
