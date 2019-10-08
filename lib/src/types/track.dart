import 'album.dart';
import 'data_list.dart';

/// Represents tracks.
class TrackInfo {
  /// ID of the track.
  String id;

  /// Name of the track.
  String name;

  /// URL of the webpage of the track.
  String url;

  /// The album that contains the song track.
  AlbumInfo album;

  /// Length of the track.
  double duration;

  /// Track order in the album.
  int trackOrderInAlbum;

  /// If the track is explicit or not.
  bool explicitness;
  List<String> territoriesThatAvailableAt;

  /// Creates a new instance.
  TrackInfo(Map<String, dynamic> jsonObject) {
    id = jsonObject['id'] ?? '';
    name = jsonObject['name'] ?? '';
    url = jsonObject['url'] ?? '';
    duration = jsonObject['duration'].toDouble() ?? 0;
    trackOrderInAlbum = jsonObject['track_number'] ?? 0;
    explicitness = jsonObject['explicitness'] ?? false;
    territoriesThatAvailableAt =
        jsonObject['available_territories'].cast<String>() ?? [];
    if (jsonObject['album'] != null) {
      album = AlbumInfo(jsonObject['album']);
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'url': url,
        'duration': duration,
        'track_number': trackOrderInAlbum,
        'explicitness': explicitness,
        'available_territories': territoriesThatAvailableAt,
        'album': album.toJson(),
      };

  @override
  String toString() {
    return '''<TrackInfo id: $id,
    name: $name,
    url: $url,
    duration: $duration,
    track_number: $trackOrderInAlbum,
    explicitness: $explicitness,
    territories: $territoriesThatAvailableAt,
    album: $album>''';
  }
}

/// Represents a list of [TrackInfo] objects.
class TrackList extends DataList<TrackInfo> {
  /// Creates a new instance.
  TrackList(Map<String, dynamic> jsonObject)
      : super(
          jsonObject,
          (map) => TrackInfo(map),
          (obj) => obj.toJson(),
        );
}
