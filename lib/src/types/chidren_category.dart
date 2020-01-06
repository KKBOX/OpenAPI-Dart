import 'data_list.dart';
import 'image.dart';
import 'paging_info.dart';
import 'summary.dart';

/// Represents categories for children contents.
class ChildrenCategory {
  /// ID of the category.
  String id;

  /// Title of the category.
  String title;

  /// Images for the category.
  List<ImageInfo> images;

  /// Creates a new instance.
  ChildrenCategory(Map<String, dynamic> jsonObject) {
    id = jsonObject['id'];
    title = jsonObject['title'];
    images = [];
    for (var imageObject in (jsonObject['images'] ?? [])) {
      images.add(ImageInfo(imageObject));
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'images': List<Map<String, dynamic>>.from(
            images.map((image) => image.toJson())),
      };

  @override
  String toString() {
    return '''<FeaturedPlaylistCategory id: $id,
    title: $title,
    images: $images''';
  }
}

/// Represents categories for children contents.
class ChildrenCategoryGroup {
  /// ID of the category.
  String id;

  /// Title of the category.
  String title;

  /// Images for the category.
  List<ImageInfo> images;

  /// Subcategories.
  List<ChildrenCategory> subcategories;

  /// The paging information.
  PagingInfo paging;

  /// The summary.
  Summary summary;

  /// Creates a new instance.
  ChildrenCategoryGroup(Map<String, dynamic> jsonObject) {
    id = jsonObject['id'];
    title = jsonObject['title'];
    images = [];
    for (var imageObject in (jsonObject['images'] ?? [])) {
      images.add(ImageInfo(imageObject));
    }
    subcategories = [];
    for (var subcategory in (jsonObject['subcategories'] ?? [])) {
      subcategories.add(ChildrenCategory(subcategory));
    }
    paging = PagingInfo(jsonObject['paging']);
    summary = Summary(jsonObject['summary']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'images': List<Map<String, dynamic>>.from(
            images.map((image) => image.toJson())),
      };

  @override
  String toString() {
    return '''<FeaturedPlaylistCategory id: $id,
    title: $title,
    images: $images''';
  }
}

/// Represents a list of [FeaturedPlaylistCategory] objects.
class ChildrenCategoryList extends DataList<ChildrenCategory> {
  /// Creates a new instance.
  ChildrenCategoryList(Map<String, dynamic> jsonObject)
      : super(
          jsonObject,
          (map) => ChildrenCategory(map),
          (obj) => obj.toJson(),
        );
}
