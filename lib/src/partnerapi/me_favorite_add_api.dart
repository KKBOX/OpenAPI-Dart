import 'dart:convert';

import 'package:kkbox_openapi/kkbox_auth.dart';
import 'package:meta/meta.dart';

import '../api/base.dart';
import '../api_base.dart';

/// Favorites a song on KKBOX by giving a [trackId].
///
/// See https://docs.kkbox.codes/docs/me-favorite-tracks-add  .
class MeFavoriteTrackAddApi
    extends KKBOXBaseApi<MeFavoriteTrackAddApiResponse> {
  /// The ID of the track to favotrite.
  final String trackId;

  /// Creates a new instance.
  MeFavoriteTrackAddApi(
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
  ContentType get contentType => ContentType.json;

  @override
  HTTPMethod get httpMethod => HTTPMethod.post;

  @override
  get postData => json.encode({'track_id': trackId});

  @override
  String get url => baseUrl(configuration) + 'me/favorite';

  @override
  MeFavoriteTrackAddApiResponse parseResult(String body) {
    final map = json.decode(body);
    return MeFavoriteTrackAddApiResponse.fromMap(map);
  }
}

/// Represents the response of [MeFavoriteTrackAddApi].
class MeFavoriteTrackAddApiResponse {
  /// The message.
  String message;

  /// The ID of the track to favorite.
  String trackId;

  /// Creates a new instance.
  MeFavoriteTrackAddApiResponse.fromMap(Map map) {
    message = map['message'];
    trackId = map['track_id'];
  }
}
