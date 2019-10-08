import 'image.dart';

/// Represents users.
class UserInfo {
  /// ID of the user.
  String id;

  /// Name of the user.
  String name;

  /// URL of the webpage of the user on KKBOX.
  String url;

  /// Description of the user.
  String description;

  /// Images of the user.
  List<ImageInfo> images;

  /// Creates a new instance.
  UserInfo(Map<String, dynamic> jsonObject) {
    id = jsonObject['id'] ?? '';
    name = jsonObject['name'] ?? '';
    url = jsonObject['url'] ?? '';
    description = jsonObject['description'] ?? '';

    images = [];
    for (var imageObject in (jsonObject['images'] ?? [])) {
      images.add(ImageInfo(imageObject));
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'url': url,
        'description': description,
        'images': images
      };
}
