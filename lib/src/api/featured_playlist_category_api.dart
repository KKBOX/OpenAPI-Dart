import 'dart:convert';

import 'package:kkbox_openapi/kkbox_auth.dart';
import 'package:kkbox_openapi/kkbox_openapi_types.dart';
import 'package:meta/meta.dart';

import 'base.dart';

/// Fetch playlists in a featured category by giving a [categoryId].
///
/// See https://docs-en.kkbox.codes/reference#featured-playlist-categories .
class FeaturedPlaylistsCategoryApi
    extends KKBOXBaseApi<FeaturedPlaylistCategory> {
  /// The ID of the desired category.
  String categoryId;

  /// The limit the amount of items in API response.
  final int limit;

  /// The offset.
  final int offset;

  /// Creates a new instance.
  FeaturedPlaylistsCategoryApi(
    this.categoryId, {
    @required String accessToken,
    @required ClientConfiguration configuration,
    Territory territory = Territory.taiwan,
    this.limit = 100,
    this.offset = 0,
  }) : super(
          accessToken: accessToken,
          configuration: configuration,
          territory: territory,
        );

  @override
  Map<String, String> get customGetParameters => {
        'territory': territoryToString(territory),
        'offset': '$offset',
        'limit': '$limit',
      };

  @override
  String get url =>
      baseUrl(configuration) + 'featured-playlist-categories/$categoryId';

  @override
  FeaturedPlaylistCategory parseResult(String body) {
    final map = json.decode(body);
    return FeaturedPlaylistCategory(map);
  }
}
