import 'artist.dart';
import 'data_list.dart';
import 'image.dart';

/// Represents an album.
class AlbumInfo {
  /// ID of the album.
  String id;

  /// Name of the album.
  String name;

  /// URL of the webpage for the album.
  String url;

  /// Artist that the album belongs to.
  ArtistInfo artist;

  /// Album cover images.
  List<ImageInfo> images;

  /// When is the album released.
  String releaseDate;

  /// If the album explicit or not.
  bool explicitness;
  List<String> territoriesThatAvailableAt;

  /// Creates a new instance.
  AlbumInfo(Map<String, dynamic> jsonObject) {
    id = jsonObject['id'] ?? '';
    name = jsonObject['name'] ?? '';
    url = jsonObject['url'] ?? '';
    releaseDate = jsonObject['release_date'] ?? '';
    explicitness = jsonObject['explicitness'] ?? false;
    territoriesThatAvailableAt =
        jsonObject['available_territories'].cast<String>() ?? [];

    if (jsonObject['artist'] != null) {
      artist = ArtistInfo(jsonObject['artist']);
    }

    images = [];
    for (final imageObject in (jsonObject['images'] ?? [])) {
      images.add(ImageInfo(imageObject));
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'url': url,
        'releaseDate': releaseDate,
        'explicitness': explicitness,
        'available_territories': territoriesThatAvailableAt,
        'artist': artist.toJson(),
        'images': List<Map<String, dynamic>>.from(
            images.map((image) => image.toJson())),
      };

  @override
  String toString() => '''<AlbumInfo id: $id,
    name: $name,
    url: $url,
    releaseDate: $releaseDate,
    images: $images,
    explicitness: $explicitness,
    territories: $territoriesThatAvailableAt,
    artist: $artist>''';
}

/// Represents a list of [AlbumInfo] objects.
class AlbumList extends DataList<AlbumInfo> {
  /// Creates a new instance.
  AlbumList(Map<String, dynamic> jsonObject)
      : super(
          jsonObject,
          (map) => AlbumInfo(map),
          (obj) => obj.toJson(),
        );
}
