import 'dart:convert';

import 'package:kkbox_openapi/kkbox_auth.dart';
import 'package:kkbox_openapi/kkbox_openapi_types.dart';
import 'package:meta/meta.dart';

import 'base.dart';

/// Fetches a playlist by giving a [playlistId].
///
/// See https://docs-en.kkbox.codes/v1.1/reference#shared-playlists_playlist_id .
class PlaylistApi extends KKBOXBaseApi<PlaylistInfo> {
  /// The ID of the desired artist.
  final String playlistId;

  /// Creates a new instance.
  PlaylistApi(
    this.playlistId, {
    @required String accessToken,
    @required ClientConfiguration configuration,
    Territory territory = Territory.taiwan,
  }) : super(
          accessToken: accessToken,
          configuration: configuration,
          territory: territory,
        );

  @override
  Map<String, String> get customGetParameters => {
        'territory': territoryToString(territory),
      };

  @override
  String get url => baseUrl(configuration) + 'shared-playlists/$playlistId';

  @override
  PlaylistInfo parseResult(String body) {
    final map = json.decode(body);
    return PlaylistInfo(map);
  }
}
