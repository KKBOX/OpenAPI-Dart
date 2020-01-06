import 'data_list.dart';
import 'image.dart';

/// Represents an artist in KKBOX's Open API.
class ArtistInfo {
  /// ID of the artist.
  String id;

  /// Name of the artist.
  String name;

  /// URL of the page of the artist.
  String url;

  /// Profile image.
  List<ImageInfo> images;

  /// Creates a new instance.
  ArtistInfo(Map<String, dynamic> jsonObject) {
    id = jsonObject['id'] ?? '';
    name = jsonObject['name'] ?? '';
    url = jsonObject['url'] ?? '';

    images = [];
    for (var imageObject in (jsonObject['images'] ?? [])) {
      images.add(ImageInfo(imageObject));
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'url': url,
        'images': List<Map<String, dynamic>>.from(
            images.map((image) => image.toJson()))
      };

  @override
  String toString() => '''<ArtistInfo id: $id,
    name: $name,
    url: $url,
    images: $images>''';
}

/// Represents a list of [ArtistInfo] objects.
class ArtistList extends DataList<ArtistInfo> {
  /// Creates a new instance.
  ArtistList(Map<String, dynamic> jsonObject)
      : super(
          jsonObject,
          (map) => ArtistInfo(map),
          (obj) => obj.toJson(),
        );
}
