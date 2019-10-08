import 'dart:convert';

import 'package:kkbox_openapi/kkbox_auth.dart';
import 'package:kkbox_openapi/kkbox_openapi_types.dart';
import 'package:meta/meta.dart';

import 'base.dart';

/// Fetches metadata of a track by giving a [trackId].
///
/// See https://docs-en.kkbox.codes/v1.1/reference#tracks-track_id .
class TrackApi extends KKBOXBaseApi<TrackInfo> {
  /// The ID of the desired track.
  final String trackId;

  /// Creates a new instance.
  TrackApi(
    this.trackId, {
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
  String get url => baseUrl(configuration) + 'tracks/$trackId';

  @override
  TrackInfo parseResult(String body) {
    final map = json.decode(body);
    return TrackInfo(map);
  }
}
