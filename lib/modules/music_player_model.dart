import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';

class MusicPlayerModel extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  List<Song> _songs = [];
  int _currentIndex = 0;
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  Song? _currentSong; // 現在再生中の曲

  AudioPlayer get audioPlayer => _audioPlayer;
  List<Song> get songs => _songs;
  int get currentIndex => _currentIndex;
  bool get isPlaying => _isPlaying;
  Duration get duration => _duration;
  Duration get position => _position;
  Song? get currentSong => _currentSong;

  MusicPlayerModel() {
    _init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
    _loadSampleSongs();

    _audioPlayer.positionStream.listen((position) {
      _position = position;
      notifyListeners();
    });

    _audioPlayer.durationStream.listen((duration) {
      _duration = duration ?? Duration.zero;
      notifyListeners();
    });

    _audioPlayer.playerStateStream.listen((state) {
      _isPlaying = state.playing;
      notifyListeners();
    });

    _audioPlayer.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        next();
      }
    });
  }

  void _loadSampleSongs() {
    _songs = [
      Song(
        id: '1',
        title: 'サンプル曲 1',
        artist: 'アーティスト 1',
        artUri: 'https://example.com/art1.jpg',
        url: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
      ),
      Song(
        id: '2',
        title: 'サンプル曲 2',
        artist: 'アーティスト 2',
        artUri: 'https://example.com/art2.jpg',
        url: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
      ),
    ];

    if (_songs.isNotEmpty) {
      _loadSong(_songs[0], 0);
    }
  }

  Future<void> _loadSong(Song song, int index) async {
    try {
      _currentIndex = index;
      _currentSong = song; // 現在再生中の曲を更新
      await _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(song.url)));
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading audio source: $e');
    }
  }

  Future<void> loadAndPlaySong(Song song) async {
    try {
      // 曲をロードして再生
      await _loadSong(song, _songs.indexOf(song));
      await _audioPlayer.play();
    } catch (e) {
      debugPrint('Error in loadAndPlaySong: $e');
    }
  }

  Future<void> playPause() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play();
    }
  }

  Future<void> next() async {
    if (_songs.isEmpty) return;
    final nextIndex = (_currentIndex + 1) % _songs.length;
    await _loadSong(_songs[nextIndex], nextIndex);
    await _audioPlayer.play();
  }

  Future<void> previous() async {
    if (_songs.isEmpty) return;
    final previousIndex = (_currentIndex - 1 + _songs.length) % _songs.length;
    await _loadSong(_songs[previousIndex], previousIndex);
    await _audioPlayer.play();
  }

  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  Future<void> playSongAt(int index) async {
    if (index >= 0 && index < _songs.length) {
      await _loadSong(_songs[index], index);
      await _audioPlayer.play();
    }
  }

  void playSong(Song song) {
    _currentSong = song;
    notifyListeners(); // 状態を更新してリスナーに通知
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}

class Song {
  final String id;
  final String title;
  final String artist;
  final String artUri;
  final String url;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.artUri,
    required this.url,
  });
}
