import 'data_list.dart';
import 'user.dart';
import 'image.dart';
import 'track.dart';

/// Represents playlists.
class PlaylistInfo {
  /// ID of the playlist.
  String id;

  /// Title of the playlist.
  String title;

  /// Description of the playlist.
  String description;

  /// URL of the webpage of the playlist.
  String url;

  /// Playlist cover images.
  List<ImageInfo> images;

  /// The user that curates the playlist.
  UserInfo owner;

  /// When was the playlist updated.
  String lastUpdateDate;

  /// Tracks in the playlists. Might be null.
  TrackList tracks;

  /// Creates a new instance.
  PlaylistInfo(Map<String, dynamic> jsonObject) {
    id = jsonObject['id'] ?? '';
    title = jsonObject['title'] ?? '';
    description = jsonObject['description'] ?? '';
    url = jsonObject['url'] ?? '';
    owner = UserInfo(jsonObject['owner'] ?? {});
    lastUpdateDate = () {
      var updatedAt = jsonObject['updated_at'];
      if (updatedAt is String) {
        return updatedAt;
      } else if (updatedAt is int) {
        return '$updatedAt';
      }
      return null;
    }();

    if (jsonObject['tracks'] != null) {
      tracks = TrackList(jsonObject['tracks']);
    }
    images = [];
    for (var imageObject in (jsonObject['images'] ?? [])) {
      images.add(ImageInfo(imageObject));
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'url': url,
        'description': description,
        'images': List<Map<String, dynamic>>.from(
            images.map((image) => image.toJson())),
        'owner': owner,
        'lastUpdateDate': lastUpdateDate,
        'tracks': tracks.toJson(),
      };

  @override
  String toString() => '''<PlaylistInfo id: $id,
    title: $title,
    url: $url,
    description: $description,
    images: $images,
    owner: $owner,
    lastUpdateDate: $lastUpdateDate,
    tracks: $tracks>''';
}

/// Represents a list of playlists.
class PlaylistList extends DataList<PlaylistInfo> {
  /// Creates a new instance.
  PlaylistList(Map<String, dynamic> jsonObject)
      : super(
          jsonObject,
          (map) => PlaylistInfo(map),
          (obj) => obj.toJson(),
        );
}
