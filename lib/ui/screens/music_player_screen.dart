import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/music_track.dart';
import '../../services/music_player_service.dart';
import '../dialogs/music_file_picker_dialog.dart';
import '../widgets/music_controls.dart';
import '../widgets/progress_bar.dart';
import '../screens/settings_screen.dart';

class MusicPlayerScreen extends StatelessWidget {
  const MusicPlayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<MusicPlayerService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Music Player'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // トラック情報表示
            Expanded(
              child: Center(
                child:
                    service.hasCurrentTrack
                        ? _buildTrackInfo(service.currentTrack!)
                        : const Text(
                          '曲が選択されていません',
                          style: TextStyle(fontSize: 18),
                        ),
              ),
            ),

            // プログレスバー
            if (service.hasCurrentTrack) const ProgressBar(),

            const SizedBox(height: 20),

            // 再生コントロール
            const MusicControls(),

            const SizedBox(height: 20),

            // 曲を選択するボタン
            ElevatedButton(
              onPressed: () async {
                final result = await showDialog<MusicTrack>(
                  context: context,
                  builder: (context) => const MusicFilePickerDialog(),
                );

                if (result != null && context.mounted) {
                  service.setTrack(result);
                }
              },
              child: const Text('曲を選択'),
            ),

            if (service.hasCurrentTrack)
              ElevatedButton(
                onPressed: () {
                  service.clear();
                },
                child: const Text('クリア'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackInfo(MusicTrack track) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (track.artworkUrl != null)
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(track.artworkUrl!),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          )
        else
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.music_note, size: 80, color: Colors.white),
          ),
        const SizedBox(height: 20),
        Text(
          track.title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          '${track.artist} - ${track.album}',
          style: const TextStyle(fontSize: 16, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
