import 'dart:convert';

import 'package:meta/meta.dart';

import '../api_base.dart';
import 'access_token.dart';
import 'client_config.dart';

/// Implements password flow.
///
/// Password flow lets you to let users to log-in into KKBOX using a [username]
/// and [password]. However, you need a client ID and client secret with
/// extra permission.
class PasswordFlowApi extends Api<AccessToken> {
  /// A configuration object including client ID, client secret and environment
  /// setting.
  final ClientConfiguration configuration;

  /// The username.
  final String username;

  /// The password.
  final String password;

  /// Creates a new instance.
  PasswordFlowApi({
    @required this.configuration,
    @required this.username,
    @required this.password,
  });

  @override
  Map<String, String> get customHTTPHeaders => {
        'Authorization': configuration.loginCredential,
        'User-Agent': configuration?.userAgent ?? '',
      };

  @override
  HTTPMethod get httpMethod => HTTPMethod.post;

  @override
  get postData => {
        'grant_type': 'password',
        'username': this.username,
        'password': this.password,
        'scope': scopesToString(this.configuration.scope),
      };

  @override
  String get url => 'https://account.kkbox.com/oauth2/token';

  @override
  AccessToken parseResult(String body) {
    Map map = json.decode(body);
    return AccessToken.fromMap(map);
  }
}
