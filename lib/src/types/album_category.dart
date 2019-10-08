import 'album.dart';
import 'data_list.dart';

/// Represnets a new released album category.
class NewReleasedAlbumsCategory {
  /// ID of the category.
  String id;

  /// Title of the category.
  String title;

  /// Albums within the category.
  AlbumList albums;

  /// Creates a new instance.
  NewReleasedAlbumsCategory(Map<String, dynamic> jsonObject) {
    id = jsonObject['id'] ?? '';
    title = jsonObject['title'] ?? '';
    if (jsonObject['albums'] != null) {
      albums = AlbumList(jsonObject['albums']);
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'albums': albums.toJson(),
      };

  @override
  String toString() => '''<NewReleasedAlbumsCategory id: $id,
    title: $title,
    albums: $albums>''';
}

/// Represents a list of [NewReleasedAlbumsCategory] objects.
class NewReleasedAlbumsCategoryList
    extends DataList<NewReleasedAlbumsCategory> {
  /// Creates a new instance.
  NewReleasedAlbumsCategoryList(Map<String, dynamic> jsonObject)
      : super(
          jsonObject,
          (map) => NewReleasedAlbumsCategory(map),
          (obj) => (obj.toJson()),
        );
}
