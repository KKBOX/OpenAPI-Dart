import 'dart:convert';

import 'package:kkbox_openapi/kkbox_auth.dart';
import 'package:kkbox_openapi/kkbox_openapi_types.dart';
import 'package:meta/meta.dart';

import '../api/base.dart';

/// Fetches information about the current user.
///
/// The API requires users to log-in into KKBOX first.
///
/// See https://docs.kkbox.codes/docs/me .
class MeApi extends KKBOXBaseApi<UserInfo> {
  /// Creates a new instance.
  MeApi({
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
  String get url => baseUrl(configuration) + 'me/';

  @override
  UserInfo parseResult(String body) {
    final map = json.decode(body);
    return UserInfo(map);
  }
}
