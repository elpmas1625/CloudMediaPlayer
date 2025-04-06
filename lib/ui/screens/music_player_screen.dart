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
    final musicService = Provider.of<MusicPlayerService>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('ホーム')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 現在再生中の曲の情報
            if (musicService.currentTrack != null) ...[
              Icon(
                Icons.music_note,
                size: 72,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 16),
              Text(
                musicService.currentTrack!.title,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                musicService.currentTrack!.artist,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ] else
              const Center(child: Text('再生中の曲はありません')),
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
