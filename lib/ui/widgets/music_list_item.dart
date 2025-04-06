import 'package:flutter/material.dart';

import '../../models/music_track.dart';

class MusicListItem extends StatelessWidget {
  final MusicTrack track;
  final VoidCallback onTap;
  final VoidCallback onMenuPressed;

  const MusicListItem({
    Key? key,
    required this.track,
    required this.onTap,
    required this.onMenuPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: ListTile(
        leading: const Icon(Icons.music_note),
        title: Text(
          track.title,
          style: Theme.of(context).textTheme.bodyLarge,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: onMenuPressed,
        ),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        visualDensity: const VisualDensity(vertical: -1),
      ),
    );
  }
}
