import 'dart:convert';

import 'package:kkbox_openapi/kkbox_auth.dart';
import 'package:meta/meta.dart';

import '../api/base.dart';
import 'private_playlist.dart';

/// Fetches a private playlist by giving a [playlistId].
///
/// The API requires users to log-in into KKBOX first.
///
/// See https://docs.kkbox.codes/docs/me-playlist-id .
class MePrivatePlaylistApi extends KKBOXBaseApi<PrivatePlaylist> {
  /// ID of the desired user.
  String playlistId;

  /// Creates a new instance.
  MePrivatePlaylistApi(
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
  String get url => baseUrl(configuration) + 'me/playlists/${playlistId}';

  @override
  PrivatePlaylist parseResult(String body) {
    final map = json.decode(body);
    return PrivatePlaylist(map);
  }
}
