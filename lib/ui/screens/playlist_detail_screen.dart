import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/playlist_service.dart';
import '../../services/music_player_service.dart';
import '../../models/playlist.dart';
import '../../models/music_track.dart';

class PlaylistDetailScreen extends StatelessWidget {
  final String playlistId;

  const PlaylistDetailScreen({Key? key, required this.playlistId})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final playlistService = Provider.of<PlaylistService>(context);
    final musicService = Provider.of<MusicPlayerService>(context);
    final playlist = playlistService.getPlaylistById(playlistId);

    if (playlist == null) {
      return const Scaffold(body: Center(child: Text('プレイリストが見つかりません')));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(playlist.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _showEditDialog(context, playlist),
          ),
        ],
      ),
      body: Column(
        children: [
          // プレイリスト情報
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Icon(Icons.queue_music, size: 48),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      playlist.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '${playlist.trackIds.length}曲',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // プレイリスト再生コントロール
          if (playlist.trackIds.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.skip_previous),
                    onPressed: () => musicService.playPreviousTrack(),
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('プレイリストを再生'),
                    onPressed:
                        () => musicService.playPlaylist(playlist.trackIds),
                  ),
                  IconButton(
                    icon: const Icon(Icons.skip_next),
                    onPressed: () => musicService.playNextTrack(), // _playNextTrack から playNextTrack に変更
                  ),
                ],
              ),
            ),

          const Divider(),

          // 曲一覧
          Expanded(
            child: ReorderableListView.builder(
              itemCount: playlist.trackIds.length,
              onReorder: (oldIndex, newIndex) {
                if (newIndex > oldIndex) newIndex--;
                playlistService.reorderTracks(playlistId, oldIndex, newIndex);
              },
              itemBuilder: (context, index) {
                final trackId = playlist.trackIds[index];
                print(
                  'Building track at index $index with ID: $trackId',
                ); // デバッグ出力

                final track = musicService.getTrackById(trackId);
                print('Track object: $track'); // より詳細なデバッグ出力
                print(
                  'Available tracks: ${musicService.allTracks.length}',
                ); // 利用可能なトラック数

                if (track == null) {
                  print('Track is null for ID: $trackId'); // デバッグ出力
                  return SizedBox.shrink(key: ValueKey('empty-$trackId'));
                }

                return ListTile(
                  key: ValueKey(playlist.trackIds[index]),
                  leading: const Icon(Icons.music_note),
                  title: Text(track.title),
                  subtitle: Text(track.artist),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      playlistService.removeTrackFromPlaylist(
                        playlistId,
                        track.id,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showEditDialog(BuildContext context, Playlist playlist) async {
    final controller = TextEditingController(text: playlist.name);
    final service = Provider.of<PlaylistService>(context, listen: false);

    return showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('プレイリスト名を編集'),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: '新しい名前'),
              autofocus: true,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('キャンセル'),
              ),
              TextButton(
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    service.updatePlaylistName(playlist.id, controller.text);
                    Navigator.pop(context);
                  }
                },
                child: const Text('保存'),
              ),
            ],
          ),
    );
  }

  void _playPlaylist(BuildContext context, Playlist playlist) {
    final musicService = Provider.of<MusicPlayerService>(
      context,
      listen: false,
    );
    musicService.playPlaylist(playlist.trackIds);
  }
}
