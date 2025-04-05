import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart' show ProcessingState;
import '../models/music_track.dart';
import '../models/player_state.dart';
import './audio_player_adapter.dart';


/// 音楽プレーヤーのビジネスロジックとステート管理を行うサービス
class MusicPlayerService extends ChangeNotifier {
  final AudioPlayerAdapter _audioAdapter;

  // プレーヤーの状態
  MusicTrack? _currentTrack;
  PlayerState _playerState = PlayerState.empty;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  double _volume = 1.0;
  RepeatMode _repeatMode = RepeatMode.off;

  // ゲッター
  MusicTrack? get currentTrack => _currentTrack;
  PlayerState get playerState => _playerState;
  Duration get position => _position;
  Duration get duration => _duration;
  double get volume => _volume;
  RepeatMode get repeatMode => _repeatMode;

  // 便利なゲッター
  bool get hasTrack => _currentTrack != null;
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

  @override
  void dispose() {
    _audioAdapter.dispose();
    super.dispose();
  }
}
