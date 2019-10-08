import 'dart:convert';

import 'package:kkbox_openapi/kkbox_auth.dart';
import 'package:kkbox_openapi/kkbox_openapi_types.dart';
import 'package:meta/meta.dart';

import '../api/base.dart';

/// Fetches tracks in a private playlist by giving a [playlistId].
///
/// The API requires users to log-in into KKBOX first.
///
/// See https://docs.kkbox.codes/docs/meplaylistsprivate_playlist_idtracks .
class MePrivatePlaylistTracksApi extends KKBOXBaseApi<TrackList> {
  /// ID of the desired user.
  String playlistId;

  /// The limit the amount of items in API response.
  final int limit;

  /// The offset.
  final int offset;

  /// Creates a new instance.
  MePrivatePlaylistTracksApi(
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
      baseUrl(configuration) + 'me/playlists/${playlistId}/tracks';

  @override
  TrackList parseResult(String body) {
    final map = json.decode(body);
    return TrackList(map);
  }
}
