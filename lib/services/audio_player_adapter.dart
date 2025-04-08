import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../models/music_track.dart';
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

  Future<void> setUrl(String assetPath, {required MusicTrack track}) async {
    try {
      // アセットファイルをローカルにコピー
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/${track.title}.mp3');

      if (!await tempFile.exists()) {
        final data = await rootBundle.load(assetPath);
        await tempFile.writeAsBytes(data.buffer.asUint8List());
      }

      final audioSource = AudioSource.file(
        tempFile.path,
        tag: MediaItem(
          id: track.id,
          title: track.title,
          artist: track.artist ?? 'Unknown Artist',
          album: track.album ?? 'Unknown Album',
        ),
      );

      await _player.setAudioSource(audioSource);
    } catch (e) {
      print('Error setting audio source: $e');
      rethrow;
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
