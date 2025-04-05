import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/music_player_service.dart';

class MusicControls extends StatelessWidget {
  const MusicControls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<MusicPlayerService>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 再生/一時停止ボタン
        IconButton(
          icon: Icon(
            service.isPlaying ? Icons.pause : Icons.play_arrow,
            size: 48,
          ),
          onPressed:
              service.hasTrack
                  ? () {
                    if (service.isPlaying) {
                      service.pause();
                    } else {
                      service.play();
                    }
                  }
                  : null,
        ),

        // 停止ボタン
        IconButton(
          icon: const Icon(Icons.stop, size: 48),
          onPressed:
              service.hasTrack
                  ? () {
                    service.stop();
                  }
                  : null,
        ),
      ],
    );
  }
}
