import 'dart:convert';

import 'package:meta/meta.dart';

import '../api_base.dart';
import 'access_token.dart';
import 'client_config.dart';

/// Implements client credentials flow.
///
/// Client credentials flow is the most easy way to start access KKBOX's Open
/// API. Just create a new instance of [ClientCredentialsFlowApi], pass your
/// client ID and client secret contained in a [ClientConfiguration] object, and
/// then call `run`.
///
/// For example:
///
/// ``` dart
/// final config =
///     ClientConfiguration(clientId: YOUR_CLIENT_ID, clientSecret: SECRET);
/// final flow = ClientCredentialsFlow(configuration: config);
/// final accessToken = await flow.run();
/// ```
///
/// See https://docs-en.kkbox.codes/v1.1/reference#client-credentials-flow and
/// https://docs.kkbox.codes/docs/client-credentials-flow .
class ClientCredentialsFlowApi extends Api<AccessToken> {
  /// A configuration object including client ID, client secret and environment
  /// setting.
  final ClientConfiguration configuration;

  /// Creates a new instance.
  ClientCredentialsFlowApi({
    @required this.configuration,
  });

  @override
  Map<String, String> get customHTTPHeaders => {
        'Authorization': configuration.loginCredential,
        'User-Agent': configuration?.userAgent ?? '',
      };

  @override
  HTTPMethod get httpMethod => HTTPMethod.post;

  @override
  Map get postData => {'grant_type': 'client_credentials'};

  @override
  String get url => 'https://account.kkbox.com/oauth2/token';

  @override
  AccessToken parseResult(String body) {
    Map map = json.decode(body);
    return AccessToken.fromMap(map);
  }
}
