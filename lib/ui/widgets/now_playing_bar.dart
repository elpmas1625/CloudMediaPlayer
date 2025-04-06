import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/music_player_service.dart';

class NowPlayingBar extends StatelessWidget {
  const NowPlayingBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<MusicPlayerService>(context);

    // 再生中の曲がない場合は表示しない
    if (!service.hasCurrentTrack) {
      return const SizedBox.shrink();
    }

    return Container(
      height: kBottomNavigationBarHeight,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        border: Border(
          top: BorderSide(color: Theme.of(context).dividerColor, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          const Icon(Icons.music_note),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              service.currentTrack?.title ?? '',
              style: Theme.of(context).textTheme.titleMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            icon: Icon(service.isPlaying ? Icons.pause : Icons.play_arrow),
            onPressed: () {
              if (service.isPlaying) {
                service.pause();
              } else {
                service.play();
              }
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
