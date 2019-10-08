import 'dart:convert';

import 'package:kkbox_openapi/kkbox_auth.dart';
import 'package:kkbox_openapi/kkbox_openapi_types.dart';
import 'package:meta/meta.dart';

import '../api/base.dart';

/// Fetches playlist collection of a user by giving a [userId].
///
/// See https://docs.kkbox.codes/docs/users-playlist-collection .
class UserPlaylistCollectionApi extends KKBOXBaseApi<PlaylistList> {
  /// ID of the desired user.
  String userId;

  /// The limit the amount of items in API response.
  final int limit;

  /// The offset.
  final int offset;

  /// Creates a new instance.
  UserPlaylistCollectionApi(
    this.userId, {
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
      baseUrl(configuration) + 'users/$userId/playlist-collection';

  @override
  PlaylistList parseResult(String body) {
    final map = json.decode(body);
    return PlaylistList(map);
  }
}
