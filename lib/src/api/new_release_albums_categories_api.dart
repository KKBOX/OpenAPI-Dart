import 'dart:convert';

import 'package:kkbox_openapi/kkbox_auth.dart';
import 'package:kkbox_openapi/kkbox_openapi_types.dart';
import 'package:meta/meta.dart';

import 'base.dart';

/// Fetches new released album categories.
///
/// See https://docs-en.kkbox.codes/reference#new-release-categories .
class NewReleasedAlbumsCategoriesApi
    extends KKBOXBaseApi<NewReleasedAlbumsCategoryList> {
  /// The limit the amount of items in API response.
  final int limit;

  /// The offset.
  final int offset;

  /// Creates a new instance.
  NewReleasedAlbumsCategoriesApi({
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
  String get url => baseUrl(configuration) + 'new-release-categories';

  @override
  NewReleasedAlbumsCategoryList parseResult(String body) {
    final map = json.decode(body);
    return NewReleasedAlbumsCategoryList(map);
  }
}
