import 'package:flutter/material.dart';
import 'home.dart';
import 'playlist.dart';
import 'library.dart';
import 'search.dart';

class MusicPlayerTabBar extends StatefulWidget {
  const MusicPlayerTabBar({super.key});

  @override
  State<MusicPlayerTabBar> createState() => _MusicPlayerTabBarState();
}

class _MusicPlayerTabBarState extends State<MusicPlayerTabBar> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const Home(),
    const Playlist(),
    const Library(),
    const Search(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_play),
            label: 'プレイリスト',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            label: 'ライブラリ',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: '検索'),
        ],
      ),
    );
  }
}
