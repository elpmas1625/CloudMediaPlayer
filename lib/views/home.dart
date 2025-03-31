import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:audio_session/audio_session.dart';
import 'dart:math';
import '../modules/music_player_model.dart';

// メインアプリケーションウィジェット
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MusicPlayerModel(),
      child: MaterialApp(
        title: '音楽再生アプリ',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          useMaterial3: true,
        ),
        home: const MusicPlayerHome(),
      ),
    );
  }
}

// 曲データモデル
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

// ホーム画面ウィジェット
class MusicPlayerHome extends StatelessWidget {
  const MusicPlayerHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('音楽再生アプリ'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // 現在再生中の曲情報
          const NowPlayingCard(),

          // 再生コントロール
          const PlayerControls(),

          // 曲リスト
          const Expanded(child: SongList()),
        ],
      ),
    );
  }
}

// 現在再生中の曲情報カード
class NowPlayingCard extends StatelessWidget {
  const NowPlayingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final playerModel = Provider.of<MusicPlayerModel>(context);
    final currentSong = playerModel.currentSong;

    if (currentSong == null) {
      return const SizedBox.shrink();
    }

    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // アルバムアート（プレースホルダー）
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Icon(Icons.music_note, size: 80, color: Colors.grey),
            ),
            const SizedBox(height: 16),

            // 曲タイトル
            Text(
              currentSong.title,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),

            // アーティスト名
            Text(
              currentSong.artist,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// 再生コントロールウィジェット
class PlayerControls extends StatelessWidget {
  const PlayerControls({super.key});

  @override
  Widget build(BuildContext context) {
    final playerModel = Provider.of<MusicPlayerModel>(context);

    // 時間をフォーマットする関数
    String _formatDuration(Duration duration) {
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      final minutes = twoDigits(duration.inMinutes.remainder(60));
      final seconds = twoDigits(duration.inSeconds.remainder(60));
      return '$minutes:$seconds';
    }

    return Column(
      children: [
        // シークバー
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Text(_formatDuration(playerModel.position)),
              Expanded(
                child: Slider(
                  value: playerModel.position.inSeconds.toDouble(),
                  min: 0,
                  max:
                      playerModel.duration.inSeconds.toDouble() > 0
                          ? playerModel.duration.inSeconds.toDouble()
                          : 1.0,
                  onChanged: (value) {
                    playerModel.seek(Duration(seconds: value.toInt()));
                  },
                ),
              ),
              Text(_formatDuration(playerModel.duration)),
            ],
          ),
        ),

        // 再生コントロールボタン
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 前の曲ボタン
            IconButton(
              icon: const Icon(Icons.skip_previous, size: 36),
              onPressed: playerModel.previous,
            ),

            // 再生/一時停止ボタン
            IconButton(
              icon: Icon(
                playerModel.isPlaying
                    ? Icons.pause_circle_filled
                    : Icons.play_circle_filled,
                size: 64,
              ),
              onPressed: playerModel.playPause,
            ),

            // 次の曲ボタン
            IconButton(
              icon: const Icon(Icons.skip_next, size: 36),
              onPressed: playerModel.next,
            ),
          ],
        ),
      ],
    );
  }
}

// 曲リストウィジェット
class SongList extends StatelessWidget {
  const SongList({super.key});

  @override
  Widget build(BuildContext context) {
    final playerModel = Provider.of<MusicPlayerModel>(context);
    final songs = playerModel.songs;

    return ListView.builder(
      itemCount: songs.length,
      itemBuilder: (context, index) {
        final song = songs[index];
        final isPlaying =
            playerModel.currentIndex == index && playerModel.isPlaying;

        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey[300],
            child: const Icon(Icons.music_note, color: Colors.grey),
          ),
          title: Text(song.title),
          subtitle: Text(song.artist),
          trailing:
              isPlaying
                  ? const Icon(Icons.volume_up, color: Colors.blue)
                  : null,
          onTap: () => playerModel.playSongAt(index),
        );
      },
    );
  }
}
