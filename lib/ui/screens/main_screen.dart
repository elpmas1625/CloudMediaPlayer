import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/music_player_service.dart';
import '../../models/tab_item.dart';
import '../widgets/now_playing_bar.dart';
import '../widgets/scrolling_text.dart';
import 'music_player_screen.dart';
import 'playlist_screen.dart';
import 'library_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TabItem _currentTab = TabItem.home;

  final Map<TabItem, Widget> _screens = {
    TabItem.home: const MusicPlayerScreen(),
    TabItem.playlist: const PlaylistScreen(),
    TabItem.library: const LibraryScreen(),
  };

  @override
  Widget build(BuildContext context) {
    final musicService = Provider.of<MusicPlayerService>(context);

    return Scaffold(
      body: Column(
        children: [
          Expanded(child: _screens[_currentTab]!),
          // ホームタブ以外で再生中音楽情報バーを表示
          if (_currentTab != TabItem.home && musicService.currentTrack != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: Border(
                  top: BorderSide(
                    color: Theme.of(context).dividerColor,
                  ),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.music_note, size: 32),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ScrollingText(
                          text: musicService.currentTrack!.title,
                          style: Theme.of(context).textTheme.titleMedium,
                          width: MediaQuery.of(context).size.width - 120, // アイコンと再生ボタンのスペースを考慮
                        ),
                        Text(
                          musicService.currentTrack!.artist,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder<bool>(
                    stream: musicService.playingStream,
                    initialData: musicService.isPlaying,
                    builder: (context, snapshot) {
                      final isPlaying = snapshot.data ?? false;
                      return IconButton(
                        icon: Icon(
                          isPlaying
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_filled,
                        ),
                        onPressed: () {
                          if (isPlaying) {
                            musicService.pause();
                          } else {
                            musicService.play();
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          // ホームタブでのみ音楽操作バーを表示
          if (_currentTab == TabItem.home)
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // シークバー
                  StreamBuilder<Duration>(
                    stream: musicService.positionStream,
                    builder: (context, snapshot) {
                      final position = snapshot.data ?? Duration.zero;
                      final duration = musicService.duration;

                      // position が duration を超えないようにする
                      final clampedPosition = Duration(
                        milliseconds: position.inMilliseconds.clamp(
                          0,
                          duration.inMilliseconds,
                        ),
                      );

                      return Column(
                        children: [
                          Slider(
                            value: clampedPosition.inMilliseconds.toDouble(),
                            min: 0,
                            max: duration.inMilliseconds.toDouble().clamp(1, double.infinity), // 0除算を防ぐ
                            onChanged: (value) {
                              musicService.seekTo(
                                Duration(milliseconds: value.round()),
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(_formatDuration(clampedPosition)),
                                Text(_formatDuration(duration)),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  // 再生コントロール
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 前の曲ボタン
                      IconButton(
                        icon: const Icon(Icons.skip_previous),
                        onPressed: musicService.hasPlaylist
                            ? () => musicService.playPreviousTrack()
                            : null,
                      ),
                      // 再生/一時停止ボタン
                      StreamBuilder<bool>(
                        stream: musicService.playingStream,
                        initialData: musicService.isPlaying,
                        builder: (context, snapshot) {
                          final isPlaying = snapshot.data ?? false;
                          return IconButton(
                            iconSize: 48,
                            icon: Icon(
                              isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                            ),
                            onPressed: musicService.currentTrack == null
                                ? null
                                : () {
                                    if (isPlaying) {
                                      musicService.pause();
                                    } else {
                                      musicService.play();
                                    }
                                  },
                          );
                        },
                      ),
                      // 次の曲ボタン
                      IconButton(
                        icon: const Icon(Icons.skip_next),
                        onPressed: musicService.hasPlaylist
                            ? () => musicService.playNextTrack()
                            : null,
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab.index,
        items: TabItem.values.map((tab) {
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

  // 時間のフォーマットヘルパーメソッド
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
