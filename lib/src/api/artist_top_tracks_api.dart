import 'dart:convert';

import 'package:kkbox_openapi/kkbox_auth.dart';
import 'package:kkbox_openapi/kkbox_openapi_types.dart';
import 'package:meta/meta.dart';

import 'base.dart';

/// Fetches top tracks of an artist by giving an [artistId],
///
/// See https://docs-en.kkbox.codes/v1.1/reference#artists-artist_id-toptracks .
class ArtistTopTracksApi extends KKBOXBaseApi<TrackList> {
  /// The ID of the desired artist.
  final String artistId;

  /// The limit the amount of items in API response.
  final int limit;

  /// The offset.
  final int offset;

  /// Creates a new instance.
  ArtistTopTracksApi(
    this.artistId, {
    @required String accessToken,
    @required ClientConfiguration configuration,
    Territory territory = Territory.taiwan,
    this.limit = 200,
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
  String get url => baseUrl(configuration) + 'artists/$artistId/top-tracks';

  @override
  TrackList parseResult(String body) {
    final map = json.decode(body);
    return TrackList(map);
  }
}
