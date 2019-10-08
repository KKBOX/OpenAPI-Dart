import 'dart:convert';

import 'package:kkbox_openapi/kkbox_auth.dart';
import 'package:kkbox_openapi/kkbox_openapi_types.dart';
import 'package:meta/meta.dart';

import 'base.dart';

/// Fetches tracks in a genre station by giving a [stationId].
///
/// See https://docs-en.kkbox.codes/v1.1/reference#genrestations-station_id .
class GenreStationApi extends KKBOXBaseApi<RadioStation> {
  /// The ID of the desired station.
  final String stationId;

  /// The limit the amount of items in API response.
  final int limit;

  /// The offset.
  final int offset;

  /// Creates a new instance.
  GenreStationApi(
    this.stationId, {
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
  String get url => baseUrl(configuration) + 'genre-stations/$stationId';

  @override
  RadioStation parseResult(String body) {
    final map = json.decode(body);
    return RadioStation(map);
  }
}
