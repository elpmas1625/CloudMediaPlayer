class MusicTrack {
  final String id;
  final String title;
  final String artist;
  final String album;
  final String url;
  final String? artworkUrl;

  const MusicTrack({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.url,
    this.artworkUrl,
  });
}
