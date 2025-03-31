import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../modules/music_player_model.dart'; // MusicPlayerModel を正しくインポート

class Library extends StatelessWidget {
  const Library({super.key});

  @override
  Widget build(BuildContext context) {
    final playerModel = Provider.of<MusicPlayerModel>(context, listen: false);

    // サンプル曲リスト
    final songs = [
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

    return Scaffold(
      appBar: AppBar(title: const Text('ライブラリ')),
      body: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          final song = songs[index];
          return ListTile(
            leading: const Icon(Icons.music_note),
            title: Text(song.title),
            subtitle: Text(song.artist),
            onTap: () {
              // 曲をロードして再生
              playerModel.loadAndPlaySong(song);

              // ホームタブへ移動
              DefaultTabController.of(context)?.animateTo(0);
            },
          );
        },
      ),
    );
  }
}
