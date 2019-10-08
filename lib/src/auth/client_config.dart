import 'dart:convert';

import 'package:meta/meta.dart';

/// Converts a string to a [Scope].
Scope scopeFromString(String string) {
  if (string == null) {
    return null;
  }
  switch (string) {
    case 'user_profile':
      return Scope.userProfile;
    case 'user_territory':
      return Scope.userTerritory;
    case 'user_account_status':
      return Scope.userAccountStatus;
    default:
      break;
  }
  return null;
}

/// Converts a string to a set of [Scope].
Set<Scope> scopesFromString(String s) {
  if (s == null) {
    return null;
  }
  // Scopes are space separated.
  Set<String> stringSet = Set<String>.from(s.split(' ').map((x) => x.trim()));
  if (stringSet.contains('all')) {
    return Set<Scope>.from(
        [Scope.userProfile, Scope.userTerritory, Scope.userAccountStatus]);
  }
  return Set<Scope>.from(
    stringSet.map((x) => scopeFromString(x)).whereType<Scope>(),
  );
}

/// Converts a set of [Scope] to a string.
String scopesToString(Set<Scope> scopes) {
  if (scopes == null) {
    return '';
  }
  return scopes.map((x) => scopeToString(x)).cast<String>().join(' ');
}

/// Converts a [Scope] to a string.
String scopeToString(Scope scope) {
  switch (scope) {
    case Scope.userProfile:
      return 'user_profile';
    case Scope.userTerritory:
      return 'user_territory';
    case Scope.userAccountStatus:
      return 'user_account_status';
  }
  return null;
}

/// Represents a  set of configurations for a client.
///
/// The configurations are including client ID, client secret and so on.
class ClientConfiguration {
  /// The client ID. You can get one from developer.kkbox.com.
  final String clientId;

  /// The client secret. You can get one from developer.kkbox.com.
  final String clientSecret;

  /// What would be used in the 'User-Agent' HTTP header field.
  final String userAgent;

  /// The requested scope.
  final Set<Scope> scope;

  /// The API environment.
  final Environment environment;

  /// Creates a new instance by passing required parameters.
  ClientConfiguration({
    @required this.clientId,
    @required this.clientSecret,
    this.userAgent = 'KKBOX OpenAPI Dart SDK',
    this.scope,
    this.environment = Environment.production,
  });

  /// The login credential composed by client ID and client secret.
  String get loginCredential {
    final String base = "${this.clientId}:${this.clientSecret}";
    final bytes = utf8.encode(base);
    final clientCredential = base64Encode(bytes);
    return 'Basic ${clientCredential}';
  }
}

/// Represents API environment.
enum Environment {
  /// The production environment.
  production,

  /// The staging environment.
  staging
}

/// Scope of your client.
enum Scope {
  /// Indicates that you can use the access token to fetch user profiles.
  userProfile,

  /// Indicates that you can use the access token to fetch the territory
  /// information of the current user.
  userTerritory,

  /// Indicates that yot can use the access token to get the account status of
  /// the current user.
  userAccountStatus
}
