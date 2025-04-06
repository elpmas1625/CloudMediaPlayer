import 'package:flutter/foundation.dart';
import '../models/playlist.dart';

class PlaylistService with ChangeNotifier {
  final List<Playlist> _playlists = [];

  List<Playlist> get playlists => List.unmodifiable(_playlists);

  Future<void> createPlaylist(String name) async {
    final playlist = Playlist(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
    );
    _playlists.add(playlist);
    notifyListeners();
  }

  // プレイリストに曲を追加
  void addTrackToPlaylist(String playlistId, String trackId) {
    final playlist = getPlaylistById(playlistId);
    if (playlist != null && !playlist.trackIds.contains(trackId)) {
      playlist.trackIds.add(trackId);
      notifyListeners();
      // デバッグ出力
      print('Added track $trackId to playlist ${playlist.name}');
      print('Playlist now has ${playlist.trackIds.length} tracks');
    }
  }

  // プレイリストから曲を削除
  void removeTrackFromPlaylist(String playlistId, String trackId) {
    final playlist = getPlaylistById(playlistId);
    if (playlist != null) {
      playlist.trackIds.remove(trackId);
      notifyListeners();
    }
  }

  Future<void> deletePlaylist(String playlistId) async {
    _playlists.removeWhere((p) => p.id == playlistId);
    notifyListeners();
  }

  Playlist? getPlaylistById(String id) {
    try {
      return _playlists.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> updatePlaylistName(String playlistId, String newName) async {
    final index = _playlists.indexWhere((p) => p.id == playlistId);
    if (index == -1) return;

    _playlists[index] = _playlists[index].copyWith(name: newName);
    notifyListeners();
  }

  // プレイリストの曲の順序を変更
  void reorderTracks(String playlistId, int oldIndex, int newIndex) {
    final playlist = getPlaylistById(playlistId);
    if (playlist != null) {
      final track = playlist.trackIds.removeAt(oldIndex);
      playlist.trackIds.insert(newIndex, track);
      notifyListeners();
    }
  }
}
