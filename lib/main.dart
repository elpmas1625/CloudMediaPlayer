import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/music_player_service.dart';
import 'ui/screens/music_player_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MusicPlayerService(),
      child: MaterialApp(
        title: 'Music Player App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const MusicPlayerScreen(),
      ),
    );
  }
}
