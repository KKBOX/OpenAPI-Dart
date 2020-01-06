import 'client_config.dart';

/// Represents access tokens.
///
/// You need an access token before accessing all of the API. Access tokens
/// could be obtained by various authentication flows, such as
/// [ClientCredentialsFlowApi], [AuthCodeFlow],
/// [DeviceCodeApi]/[DeviceCodeFlowTokenApi], [PasswordFlowApi], and so on.
class AccessToken {
  /// The access token.
  final String accessToken;

  /// When will the access token expire since now in seconds.
  final int expiresIn;

  /// The refresh token. Might be null.
  final String refreshToken;

  /// The scopes of the access token. Might be null.
  final Set<Scope> scopes;

  /// The type of the token.
  final String tokenType;

  /// Creates a new instance.
  AccessToken({
    this.accessToken,
    this.expiresIn,
    this.refreshToken,
    this.scopes,
    this.tokenType,
  });

  /// Creates a new instance.
  factory AccessToken.fromMap(Map map) {
    final accessToken = map['access_token'];
    final tokenType = map['token_type'];
    final expiresIn = map['expires_in'];
    final refreshToken = map['refresh_token'];
    final scopeString = map['scope'];
    var scopes =
        scopeString != null ? scopesFromString(scopeString) : <Scope>{};
    return AccessToken(
      accessToken: accessToken,
      tokenType: tokenType,
      expiresIn: expiresIn,
      refreshToken: refreshToken,
      scopes: scopes,
    );
  }

  /// Converts to a map representation;
  Map toMap() {
    var map = {
      'access_token': accessToken,
      'token_type': tokenType,
      'expires_in': expiresIn
    };
    if (refreshToken != null) {
      map['refresh_token'] = refreshToken;
    }
    if (scopes != null && scopes.isEmpty == false) {
      map['refresh_token'] = scopesToString(scopes);
    }
    return map;
  }

  /// Converts to a map representation;
  Map toJson() => toMap();

  /// Validates if we can convert a [map] to an OneTimePassword object.
  static bool validate(Map map) {
    return map['access_token'] is String &&
        map['token_type'] is String &&
        map['expires_in'] is int;
  }
}
