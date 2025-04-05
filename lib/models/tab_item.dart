import 'package:flutter/material.dart';

enum TabItem {
  home(label: 'ホーム', icon: Icons.home),
  playlist(label: 'プレイリスト', icon: Icons.queue_music),
  settings(label: '設定', icon: Icons.settings);

  const TabItem({required this.label, required this.icon});

  final String label;
  final IconData icon;
}
