import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/playlist_service.dart';
import 'playlist_detail_screen.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<PlaylistService>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('プレイリスト')),
      body:
          service.playlists.isEmpty
              ? const Center(child: Text('プレイリストがありません'))
              : ListView.builder(
                itemCount: service.playlists.length,
                itemBuilder: (context, index) {
                  final playlist = service.playlists[index];
                  return ListTile(
                    leading: const Icon(Icons.queue_music),
                    title: Text(playlist.name),
                    subtitle: Text('${playlist.trackIds.length} 曲'),
                    trailing: IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {
                        _showPlaylistMenu(context, playlist.id);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  PlaylistDetailScreen(playlistId: playlist.id),
                        ),
                      );
                    },
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreatePlaylistDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _showCreatePlaylistDialog(BuildContext context) async {
    final controller = TextEditingController();
    final service = Provider.of<PlaylistService>(context, listen: false);

    return showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('新規プレイリスト'),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: 'プレイリスト名'),
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
                    service.createPlaylist(controller.text);
                    Navigator.pop(context);
                  }
                },
                child: const Text('作成'),
              ),
            ],
          ),
    );
  }

  Future<void> _showPlaylistMenu(
    BuildContext context,
    String playlistId,
  ) async {
    final service = Provider.of<PlaylistService>(context, listen: false);

    return showModalBottomSheet(
      context: context,
      builder:
          (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('削除'),
                onTap: () {
                  service.deletePlaylist(playlistId);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
    );
  }
}
