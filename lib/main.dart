import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/music_player_service.dart';
import 'services/playlist_service.dart';
import 'ui/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final musicPlayerService = MusicPlayerService();
  await musicPlayerService.loadMusicFiles();

  runApp(MyApp(musicPlayerService: musicPlayerService));
}

class MyApp extends StatelessWidget {
  final MusicPlayerService musicPlayerService;

  const MyApp({Key? key, required this.musicPlayerService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: musicPlayerService),
        ChangeNotifierProvider(create: (_) => PlaylistService()),
      ],
      child: MaterialApp(
        title: 'Music Player App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const MainScreen(),
      ),
    );
  }
}
