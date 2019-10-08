import 'data_list.dart';
import 'image.dart';
import 'playlist.dart';

/// Represents playlist categories.
class FeaturedPlaylistCategory {
  /// ID of the category.
  String id;

  /// Title of the category.
  String title;

  /// Images for the category.
  List<ImageInfo> images;

  /// Playlists under the category. It might be null.
  PlaylistList playlists;

  /// Creates a new instance.
  FeaturedPlaylistCategory(Map<String, dynamic> jsonObject) {
    id = jsonObject['id'];
    title = jsonObject['title'];
    images = [];
    for (var imageObject in (jsonObject['images'] ?? [])) {
      images.add(ImageInfo(imageObject));
    }
    if (jsonObject['playlists'] != null) {
      playlists = PlaylistList(jsonObject['playlists']);
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'images': List<Map<String, dynamic>>.from(
            images.map((image) => image.toJson())),
        'playlists': playlists.toJson(),
      };

  @override
  String toString() {
    return '''<FeaturedPlaylistCategory id: $id,
    title: $title,
    images: $images,
    playlists: $playlists>''';
  }
}

/// Represents a list of [FeaturedPlaylistCategory] objects.
class FeaturedPlaylistCategoryList extends DataList<FeaturedPlaylistCategory> {
  /// Creates a new instance.
  FeaturedPlaylistCategoryList(Map<String, dynamic> jsonObject)
      : super(
          jsonObject,
          (map) => FeaturedPlaylistCategory(map),
          (obj) => obj.toJson(),
        );
}
