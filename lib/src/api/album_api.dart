import 'dart:convert';

import 'package:kkbox_openapi/kkbox_auth.dart';
import 'package:kkbox_openapi/kkbox_openapi_types.dart';
import 'package:meta/meta.dart';

import 'base.dart';

/// Fetches metadata of an album by giving an [albumId]
///
/// See https://docs-en.kkbox.codes/reference#albums_album_id .
class AlbumApi extends KKBOXBaseApi<AlbumInfo> {
  /// The ID of the desired album.
  final String albumId;

  /// Creates a new instance.
  AlbumApi(
    this.albumId, {
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
  String get url => baseUrl(configuration) + 'albums/$albumId';

  @override
  AlbumInfo parseResult(String body) {
    final map = json.decode(body);
    return AlbumInfo(map);
  }
}
