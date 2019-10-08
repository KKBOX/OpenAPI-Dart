import 'dart:convert';

import 'package:kkbox_openapi/kkbox_auth.dart';
import 'package:kkbox_openapi/kkbox_openapi_types.dart';
import 'package:meta/meta.dart';

import '../api/base.dart';

/// Fetches playlist collection of the current user.
///
/// The API requires users to log-in into KKBOX first.
///
/// See https://docs.kkbox.codes/docs/me-playlist-collection .
class MePlaylistCollectionApi extends KKBOXBaseApi<PlaylistList> {
  /// The limit the amount of items in API response.
  final int limit;

  /// The offset.
  final int offset;

  /// Creates a new instance.
  MePlaylistCollectionApi({
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
  String get url => baseUrl(configuration) + 'me/playlist-collection';

  @override
  PlaylistList parseResult(String body) {
    final map = json.decode(body);
    return PlaylistList(map);
  }
}
