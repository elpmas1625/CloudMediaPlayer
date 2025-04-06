import 'package:just_audio/just_audio.dart';
import '../models/player_state.dart';

/// 外部オーディオプレーヤーライブラリのラッパー
class AudioPlayerAdapter {
  final _player = AudioPlayer();

  // ストリーム
  Stream<Duration> get positionStream => _player.positionStream;
  Stream<Duration?> get durationStream => _player.durationStream;
  Stream<bool> get playingStream => _player.playingStream;
  Stream<ProcessingState> get processingStateStream =>
      _player.processingStateStream;

  Future<void> setUrl(String url) async {
    if (url.startsWith('assets/')) {
      await _player.setAsset(url);
    } else {
      await _player.setUrl(url);
    }
  }

  Future<void> play() async {
    await _player.play();
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> stop() async {
    await _player.stop();
  }

  // シーク
  Future<void> seekTo(Duration position) async {
    await _player.seek(position);
  }

  Future<void> setVolume(double volume) async {
    await _player.setVolume(volume);
  }

  Future<void> setLoopMode(RepeatMode mode) async {
    switch (mode) {
      case RepeatMode.off:
        await _player.setLoopMode(LoopMode.off);
        break;
      case RepeatMode.one:
        await _player.setLoopMode(LoopMode.one);
        break;
      case RepeatMode.all:
        await _player.setLoopMode(LoopMode.all);
        break;
    }
  }

  void dispose() {
    _player.dispose();
  }
}
