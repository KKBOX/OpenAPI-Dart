/// Represents metadata of an image.
class ImageInfo {
  /// Width of the image.
  double width = 0.0;

  /// Height of the image.
  double height = 0.0;

  /// URL of the image.
  String url;

  /// Creates a new instance.
  ImageInfo(Map<String, dynamic> jsonObject) {
    width = jsonObject['width'].toDouble() ?? 0.0;
    height = jsonObject['height'].toDouble() ?? 0.0;
    url = jsonObject['url'] ?? url;
  }

  Map<String, dynamic> toJson() =>
      {'width': width, 'height': height, 'url': url};

  @override
  String toString() => '''<Image url: $url, width: $width, height: $height>''';
}
