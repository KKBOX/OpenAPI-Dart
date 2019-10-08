import 'package:kkbox_openapi/kkbox_openapi_types.dart';

/// Represents private playlists of KKBOX users.
class PrivatePlaylist {
  /// ID of the playlist.
  String id;

  /// Title of the playlist.
  String title;

  /// Tracks in the playlists. Might be null.
  TrackList tracks;

  /// Creates a new instance.
  PrivatePlaylist(Map map) {
    id = map['id'] ?? '';
    title = map['title'] ?? '';
    if (map['tracks'] != null) {
      tracks = TrackList(map['tracks']);
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'tracks': tracks.toJson(),
      };
}

/// Represents a list of [PrivatePlaylist] objects.
class PrivatePlaylistList extends DataList<PrivatePlaylist> {
  /// Creates a new instance.
  PrivatePlaylistList(Map<String, dynamic> jsonObject)
      : super(
          jsonObject,
          (map) => PrivatePlaylist(map),
          (obj) => obj.toJson(),
        );
}
