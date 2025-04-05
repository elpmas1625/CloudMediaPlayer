import 'package:flutter/material.dart';
import '../../models/tab_item.dart';
import 'music_player_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TabItem _currentTab = TabItem.home;

  final Map<TabItem, Widget> _screens = {
    TabItem.home: const MusicPlayerScreen(),
    TabItem.playlist: const Center(child: Text('プレイリスト')),
    TabItem.settings: const Center(child: Text('設定')),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab.index,
        items:
            TabItem.values.map((tab) {
              return BottomNavigationBarItem(
                icon: Icon(tab.icon),
                label: tab.label,
              );
            }).toList(),
        onTap: (index) {
          setState(() {
            _currentTab = TabItem.values[index];
          });
        },
      ),
    );
  }
}
