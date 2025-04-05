import 'package:flutter/material.dart';

enum TabItem {
  home(label: 'ホーム', icon: Icons.home),
  playlist(label: 'プレイリスト', icon: Icons.queue_music);

  const TabItem({required this.label, required this.icon});

  final String label;
  final IconData icon;
}
