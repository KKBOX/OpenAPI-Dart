import 'data_list.dart';
import 'image.dart';
import 'track.dart';

/// Represents radio stations on KKBOX, including mood stations and genre
/// stations.
class RadioStation {
  /// ID of the radio station.
  String id;

  /// Name of the radio station.
  String name;

  /// Category of the radio station. Only applied on genre stations.
  String category;

  /// Images of the radio station. Only applied on mood stations.
  List<ImageInfo> images;

  /// Tracks in the station.
  TrackList tracks;

  RadioStation(Map<String, dynamic> jsonObject) {
    id = jsonObject['id'] ?? '';
    name = jsonObject['name'] ?? '';
    category = jsonObject['category'];

    images = [];
    for (var imageObject in (jsonObject['images'] ?? [])) {
      images.add(ImageInfo(imageObject));
    }
    if (jsonObject['tracks'] != null) {
      tracks = TrackList(jsonObject['tracks']);
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
        'images': List<Map<String, dynamic>>.from(
            images.map((image) => image.toJson())),
        'tracks': tracks.toJson(),
      };

  @override
  String toString() => '''<RadioStation id: $id,
    name: $name,
    category: $category,
    images: $images,
    tracks: $tracks>''';
}

/// Represents a list of [RadioStation] objects.
class RadioStationList extends DataList<RadioStation> {
  /// Creates a new instance.
  RadioStationList(Map<String, dynamic> jsonObject)
      : super(
          jsonObject,
          (map) => RadioStation(map),
          (obj) => obj.toJson(),
        );
}
