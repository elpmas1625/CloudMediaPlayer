import 'package:flutter/foundation.dart';
import '../models/music_track.dart';

class MusicLibraryService with ChangeNotifier {
  static const int _cacheSize = 100; // キャッシュするトラック数
  static const int pageSize = 50; // 1ページあたりの曲数

  final Map<String, MusicTrack> _trackCache = {};
  final List<String> _allTrackPaths = [];
  bool _isInitialized = false;

  // キャッシュされたトラックの取得
  MusicTrack? getCachedTrack(String path) => _trackCache[path];

  // トラックのキャッシュへの追加
  void _addToCache(MusicTrack track) {
    if (_trackCache.length >= _cacheSize) {
      _trackCache.remove(_trackCache.keys.first);
    }
    _trackCache[track.id] = track;
  }

  // ページ単位でのデータ取得
  Future<List<MusicTrack>> getTracksForPage(int page) async {
    final startIndex = page * pageSize;
    if (startIndex >= _allTrackPaths.length) return [];

    final endIndex =
        (startIndex + pageSize) > _allTrackPaths.length
            ? _allTrackPaths.length
            : startIndex + pageSize;

    final tracks = <MusicTrack>[];
    for (var i = startIndex; i < endIndex; i++) {
      final path = _allTrackPaths[i];
      var track = getCachedTrack(path);
      if (track == null) {
        track = await _createTrackFromPath(path);
        _addToCache(track);
      }
      tracks.add(track);
    }
    return tracks;
  }

  Future<MusicTrack> _createTrackFromPath(String path) async {
    // TODO: 将来的にメタデータを取得する実装に置き換え
    final fileName = path.split('/').last.replaceAll('.mp3', '');
    return MusicTrack(
      id: path,
      title: fileName,
      artist: 'Unknown',
      album: 'Local Music',
      url: path,
    );
  }
}
