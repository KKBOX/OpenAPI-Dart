import 'dart:convert';

import 'package:kkbox_openapi/kkbox_auth.dart';
import 'package:kkbox_openapi/kkbox_openapi_types.dart';
import 'package:meta/meta.dart';

import '../api/base.dart';

/// Fetches information about a user by giving a [userId].
///
/// See https://docs.kkbox.codes/docs/user-profile .
class UserApi extends KKBOXBaseApi<UserInfo> {
  /// ID of the desired user.
  String userId;

  /// Creates a new instance.
  UserApi(
    this.userId, {
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
  String get url => baseUrl(configuration) + 'users/$userId';

  @override
  UserInfo parseResult(String body) {
    final map = json.decode(body);
    return UserInfo(map);
  }
}
