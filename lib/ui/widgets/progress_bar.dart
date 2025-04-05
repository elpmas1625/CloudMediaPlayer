import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/music_player_service.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<MusicPlayerService>(context);

    String formatDuration(Duration duration) {
      return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    }

    return Column(
      children: [
        Slider(
          value: service.progress,
          onChanged:
              service.hasTrack
                  ? (value) {
                    final position = Duration(
                      milliseconds:
                          (value * service.duration.inMilliseconds).round(),
                    );
                    service.seekTo(position);
                  }
                  : null,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(formatDuration(service.position)),
              Text(formatDuration(service.duration)),
            ],
          ),
        ),
      ],
    );
  }
}
