class Playlist {
  final String id;
  final String name;
  final List<String> trackIds;
  final DateTime createdAt;
  final DateTime updatedAt;

  Playlist({
    required this.id,
    required this.name,
    List<String>? trackIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : trackIds = trackIds ?? [],
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  Playlist copyWith({
    String? name,
    List<String>? trackIds,
    DateTime? updatedAt,
  }) {
    return Playlist(
      id: id,
      name: name ?? this.name,
      trackIds: trackIds ?? this.trackIds,
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }
}
