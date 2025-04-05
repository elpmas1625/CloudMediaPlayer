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

          // 再生ボタン
          if (playlist.trackIds.isNotEmpty)
            ElevatedButton.icon(
              icon: const Icon(Icons.play_arrow),
              label: const Text('プレイリストを再生'),
              onPressed: () => _playPlaylist(context, playlist),
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
                final track = musicService.getTrackById(
                  playlist.trackIds[index],
                );
                if (track == null) return const SizedBox.shrink();

                return ListTile(
                  key: ValueKey(track.id),
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
