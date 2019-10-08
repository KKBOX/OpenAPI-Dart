import 'dart:convert';

import 'package:meta/meta.dart';

import '../api_base.dart';
import 'access_token.dart';
import 'client_config.dart';

/// Helps to generate a URL to let users to log-in into KKBOX using a webview.
///
/// The authentication flow uses webviews to do authentication in order to
/// prevent your client to access users' usernames and passwords. Once your
/// webview open the [AuthCodeFlow.loginDialogUrl], wait for the webview calls
/// your [AuthCodeFlow.redirectUri], and then you can get an authentication code
/// or an error. Pass the authentication code to [AuthCodeFlowTokenApi], you can
/// then get an [AccessToken].
///
/// See https://docs.kkbox.codes/docs/kkbox-oauth-20-authorize-api .
class AuthCodeFlow {
  /// A configuration object including client ID, client secret and environment
  /// setting.
  final ClientConfiguration configuration;

  /// The redirect URI.
  final String redirectUri;

  /// The state.
  final String state;

  AuthCodeFlow({
    @required this.configuration,
    @required this.redirectUri,
    this.state,
  });

  String get loginDialogUrl {
    String url = 'https://account.kkbox.com/oauth2/authorize'
        '?client_id=${this.configuration.clientId}'
        '&response_type=code'
        '&scope=${scopesToString(this.configuration.scope)}'
        '&redirect_uri=${this.redirectUri}';
    if (this.state != null) {
      url += '&state=${this.state}';
    }
    return url;
  }
}

/// Fetches an access token by giving an [authCode].
///
/// To learn about how to get the [authCode], see [AuthCodeFlow].
///
/// See https://docs.kkbox.codes/docs/oauth2-token-api-authorization-code-flow .
class AuthCodeFlowTokenApi extends Api<AccessToken> {
  /// A configuration object including client ID, client secret and environment
  /// setting.
  final ClientConfiguration configuration;

  /// The deviceCode.
  final authCode;

  /// Creates a new instance.
  AuthCodeFlowTokenApi({
    @required this.authCode,
    @required this.configuration,
  });

  @override
  ContentType get contentType => ContentType.wwwFormUrlencoded;

  @override
  HTTPMethod get httpMethod => HTTPMethod.post;

  @override
  get postData => {
        'grant_type': 'authorization_code',
        'client_id': this.configuration.clientId,
        'client_secret': this.configuration.clientSecret,
        'code': this.authCode,
      };

  @override
  String get url => 'https://account.kkbox.com/oauth2/token';

  @override
  AccessToken parseResult(String body) {
    final map = json.decode(body);
    return AccessToken.fromMap(map);
  }
}
