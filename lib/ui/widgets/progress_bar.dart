import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/music_player_service.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<MusicPlayerService>(context);
    final position = service.position.inMilliseconds.toDouble();
    final duration = service.duration.inMilliseconds.toDouble();

    // 0.0から1.0の間に収まるように正規化
    final value = duration > 0 ? (position / duration).clamp(0.0, 1.0) : 0.0;

    return Column(
      children: [
        Slider(
          value: value,
          onChanged: (newValue) {
            final newPosition = Duration(
              milliseconds: (newValue * duration).toInt(),
            );
            service.seekTo(newPosition);
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_formatDuration(service.position)),
              Text(_formatDuration(service.duration)),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
