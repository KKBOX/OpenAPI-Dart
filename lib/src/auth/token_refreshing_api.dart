import 'dart:convert';

import 'package:meta/meta.dart';

import '../api_base.dart';
import 'access_token.dart';
import 'client_config.dart';

/// Represents that [TokenRefreshingApi] failed to refresh tokens.
class RefreshingFailedException implements Exception {
  final String currentRefreshToken;
  RefreshingFailedException(this.currentRefreshToken);
}

/// Refreshes an [AccessToken] by [AccessToken.refreshToken].
///
/// See https://docs.kkbox.codes/docs/oauth2-token-api-refresh-token .
class TokenRefreshingApi extends Api<AccessToken> {
  /// A configuration object including client ID, client secret and environment
  /// setting.
  final ClientConfiguration configuration;

  /// The refresh token.
  final refreshToken;

  /// Creates a new instance.
  TokenRefreshingApi({
    @required this.refreshToken,
    @required this.configuration,
  });

  @override
  ContentType get contentType => ContentType.wwwFormUrlencoded;

  @override
  Map<String, String> get customHTTPHeaders => {
        'Authorization': configuration.loginCredential,
        'User-Agent': configuration?.userAgent ?? '',
      };

  @override
  HTTPMethod get httpMethod => HTTPMethod.post;

  @override
  get postData => {
        'grant_type': 'refresh_token',
        'refresh_token': refreshToken,
      };

  @override
  String get url => 'https://account.kkbox.com/oauth2/token';

  @override
  AccessToken parseResult(String body) {
    final map = json.decode(body);
    final accessToken = AccessToken.fromMap(map);
    if (accessToken.accessToken == null || accessToken.refreshToken == null) {
      throw RefreshingFailedException(this.refreshToken);
    }
    return accessToken;
  }
}
