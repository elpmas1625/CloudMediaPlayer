import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import '../../models/music_track.dart';
import '../../services/music_player_service.dart';
import 'package:provider/provider.dart';

import '../../services/playlist_service.dart';
import '../widgets/music_list_item.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ライブラリ')),
      body: const MusicFileList(),
    );
  }
}

class MusicFileList extends StatefulWidget {
  const MusicFileList({Key? key}) : super(key: key);

  @override
  State<MusicFileList> createState() => _MusicFileListState();
}

class _MusicFileListState extends State<MusicFileList> {
  static const int _pageSize = 50; // 1ページあたりの曲数を50に増加
  static const int _prefetchThreshold = 500; // プリフェッチのトリガー距離

  final ScrollController _scrollController = ScrollController();
  final List<MusicTrack> _displayedTracks = [];
  final Set<String> _loadedFiles = {}; // 重複ロード防止用
  bool _isLoading = false;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_isLoading &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - _prefetchThreshold) {
      _loadMoreData();
    }
  }

  Future<void> _loadInitialData() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    try {
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);

      final allFiles =
          manifestMap.keys
              .where(
                (String key) =>
                    key.startsWith('assets/music/') && key.endsWith('.mp3'),
              )
              .toList();

      final initialFiles = allFiles.take(_pageSize).toList();
      final newTracks =
          initialFiles.map((file) {
            final fileName = file.split('/').last.replaceAll('.mp3', '');
            return MusicTrack(
              id: file,
              title: fileName,
              artist: 'Unknown',
              album: 'Local Music',
              url: file,
            );
          }).toList();

      setState(() {
        _displayedTracks.addAll(newTracks);
        _loadedFiles.addAll(initialFiles);
        _currentPage = 1;
      });
    } catch (e) {
      debugPrint('Error loading music files: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loadMoreData() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    try {
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);

      final allFiles =
          manifestMap.keys
              .where(
                (String key) =>
                    key.startsWith('assets/music/') && key.endsWith('.mp3'),
              )
              .toList();

      final start = _currentPage * _pageSize;
      if (start >= allFiles.length) {
        setState(() => _isLoading = false);
        return;
      }

      final end =
          (start + _pageSize) > allFiles.length
              ? allFiles.length
              : start + _pageSize;

      final newFiles = allFiles.sublist(start, end);
      final newTracks =
          newFiles.where((file) => !_loadedFiles.contains(file)).map((file) {
            final fileName = file.split('/').last.replaceAll('.mp3', '');
            return MusicTrack(
              id: file,
              title: fileName,
              artist: 'Unknown',
              album: 'Local Music',
              url: file,
            );
          }).toList();

      setState(() {
        _displayedTracks.addAll(newTracks);
        _loadedFiles.addAll(newFiles);
        _currentPage++;
      });
    } catch (e) {
      debugPrint('Error loading more music files: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _onTrackTap(MusicTrack track) {
    final musicService = Provider.of<MusicPlayerService>(
      context,
      listen: false,
    );

    musicService.setTrack(track);
    musicService.play();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _displayedTracks.length + 1,
      itemBuilder: (context, index) {
        if (index == _displayedTracks.length) {
          return _isLoading
              ? const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: CircularProgressIndicator()),
              )
              : const SizedBox.shrink();
        }

        final track = _displayedTracks[index];
        return MusicListItem(
          key: ValueKey(track.id),
          track: track,
          onTap: () => _onTrackTap(track),
          onMenuPressed: () => _showOptionsMenu(context, track),
        );
      },
    );
  }

  void _showOptionsMenu(BuildContext context, MusicTrack track) {
    final musicService = Provider.of<MusicPlayerService>(
      context,
      listen: false,
    );
    final playlistService = Provider.of<PlaylistService>(
      context,
      listen: false,
    );

    showModalBottomSheet(
      context: context,
      builder:
          (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.play_arrow),
                title: const Text('再生'),
                onTap: () {
                  musicService.setTrack(track);
                  musicService.play();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.playlist_add),
                title: const Text('プレイリストに追加'),
                onTap: () {
                  Navigator.pop(context);
                  _showAddToPlaylistDialog(context, track);
                },
              ),
              ListTile(
                leading: const Icon(Icons.queue_music),
                title: const Text('次に再生'),
                onTap: () {
                  // TODO: 次の曲として追加する機能を実装
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('ファイル情報'),
                onTap: () {
                  Navigator.pop(context);
                  _showFileInfoDialog(context, track);
                },
              ),
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text('共有'),
                onTap: () {
                  // TODO: 共有機能を実装
                  Navigator.pop(context);
                },
              ),
            ],
          ),
    );
  }

  void _showAddToPlaylistDialog(BuildContext context, MusicTrack track) {
    final playlistService = Provider.of<PlaylistService>(
      context,
      listen: false,
    );
    final musicService = Provider.of<MusicPlayerService>(
      context,
      listen: false,
    );
    final playlists = playlistService.playlists;

    // トラックを MusicPlayerService に追加
    musicService.addTrack(track);

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('プレイリストを選択'),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: playlists.length,
                itemBuilder: (context, index) {
                  final playlist = playlists[index];
                  return ListTile(
                    title: Text(playlist.name),
                    onTap: () {
                      playlistService.addTrackToPlaylist(playlist.id, track.id);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${track.title}を${playlist.name}に追加しました',
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('キャンセル'),
              ),
            ],
          ),
    );
  }

  void _showFileInfoDialog(BuildContext context, MusicTrack track) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('ファイル情報'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('タイトル', track.title),
                _buildInfoRow('アーティスト', track.artist),
                _buildInfoRow('アルバム', track.album),
                _buildInfoRow('ファイルパス', track.url),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('閉じる'),
              ),
            ],
          ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          Text(value),
        ],
      ),
    );
  }
}
