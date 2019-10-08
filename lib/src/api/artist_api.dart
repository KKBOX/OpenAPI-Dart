import 'dart:convert';

import 'package:kkbox_openapi/kkbox_auth.dart';
import 'package:kkbox_openapi/kkbox_openapi_types.dart';
import 'package:meta/meta.dart';

import 'base.dart';

/// Fetches metadata of an artist by giving an [artistId]
///
/// See https://docs-en.kkbox.codes/v1.1/reference#artists-artist_id .
class ArtistApi extends KKBOXBaseApi<ArtistInfo> {
  /// The ID of the desired artist.
  final String artistId;

  /// Creates a new instance.
  ArtistApi(
    this.artistId, {
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
  String get url => baseUrl(configuration) + 'artists/$artistId';

  @override
  ArtistInfo parseResult(String body) {
    final map = json.decode(body);
    return ArtistInfo(map);
  }
}
