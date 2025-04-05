import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import '../../models/music_track.dart';
import '../../services/music_player_service.dart';
import 'package:provider/provider.dart';

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
  final ScrollController _scrollController = ScrollController();
  final List<String> _musicFiles = [];
  bool _isLoading = false;
  static const int _pageSize = 20;
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
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
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
      setState(() {
        _musicFiles.addAll(initialFiles);
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
      setState(() {
        _musicFiles.addAll(newFiles);
        _currentPage++;
      });
    } catch (e) {
      debugPrint('Error loading more music files: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final musicService = Provider.of<MusicPlayerService>(context);

    return ListView.builder(
      controller: _scrollController,
      itemCount: _musicFiles.length + 1,
      itemBuilder: (context, index) {
        if (index == _musicFiles.length) {
          return _isLoading
              ? const Center(child: CircularProgressIndicator())
              : const SizedBox.shrink();
        }

        final filePath = _musicFiles[index];
        final fileName = filePath.split('/').last.replaceAll('.mp3', '');

        return ListTile(
          leading: const Icon(Icons.music_note),
          title: Text(fileName),
          onTap: () {
            final track = MusicTrack(
              id: index.toString(),
              title: fileName,
              artist: 'Unknown',
              album: 'Local Music',
              url: filePath,
            );
            musicService.setTrack(track);
          },
        );
      },
    );
  }
}
