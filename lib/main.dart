import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/tabbar.dart';
import 'modules/music_player_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MusicPlayerModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '音楽再生アプリ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: const MusicPlayerTabBar(),
    );
  }
}
