import 'package:flutter/foundation.dart';
import '../models/playlist.dart';

class PlaylistService extends ChangeNotifier {
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

  Future<void> addTrackToPlaylist(String playlistId, String trackId) async {
    final index = _playlists.indexWhere((p) => p.id == playlistId);
    if (index == -1) return;

    final playlist = _playlists[index];
    if (playlist.trackIds.contains(trackId)) return;

    _playlists[index] = playlist.copyWith(
      trackIds: [...playlist.trackIds, trackId],
    );
    notifyListeners();
  }

  Future<void> removeTrackFromPlaylist(
    String playlistId,
    String trackId,
  ) async {
    final index = _playlists.indexWhere((p) => p.id == playlistId);
    if (index == -1) return;

    final playlist = _playlists[index];
    _playlists[index] = playlist.copyWith(
      trackIds: playlist.trackIds.where((id) => id != trackId).toList(),
    );
    notifyListeners();
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

  Future<void> reorderTracks(
    String playlistId,
    int oldIndex,
    int newIndex,
  ) async {
    final playlist = getPlaylistById(playlistId);
    if (playlist == null) return;

    final tracks = List<String>.from(playlist.trackIds);
    final item = tracks.removeAt(oldIndex);
    tracks.insert(newIndex, item);

    final index = _playlists.indexWhere((p) => p.id == playlistId);
    _playlists[index] = playlist.copyWith(trackIds: tracks);
    notifyListeners();
  }
}
