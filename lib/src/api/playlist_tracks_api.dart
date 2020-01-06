import 'dart:convert';

import 'package:kkbox_openapi/kkbox_auth.dart';
import 'package:kkbox_openapi/kkbox_openapi_types.dart';
import 'package:meta/meta.dart';

import 'base.dart';

/// Fetches tracks contained in a playlist by giving a [playlistId].
///
/// See https://docs-en.kkbox.codes/reference#shared-playlists_playlist_id_tracks .
class PlaylistTracksApi extends KKBOXBaseApi<TrackList> {
  /// The ID of the desired artist.
  final String playlistId;

  /// The limit the amount of items in API response.
  final int limit;

  /// The offset.
  final int offset;

  /// Creates a new instance.
  PlaylistTracksApi(
    this.playlistId, {
    @required String accessToken,
    @required ClientConfiguration configuration,
    Territory territory = Territory.taiwan,
    this.limit = 500,
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
      baseUrl(configuration) + 'shared-playlists/$playlistId/tracks';

  @override
  TrackList parseResult(String body) {
    final map = json.decode(body);
    return TrackList(map);
  }
}
