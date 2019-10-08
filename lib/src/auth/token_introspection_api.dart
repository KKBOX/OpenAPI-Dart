import 'dart:convert';

import 'package:meta/meta.dart';

import '../api/base.dart';
import '../api_base.dart';
import 'access_token.dart';
import 'client_config.dart';

/// Converts a string to an [AccountStatus].
AccountStatus accountStatusFromString(String string) {
  switch (string) {
    case 'PREMIUM':
      return AccountStatus.premium;
    case 'TRIAL':
      return AccountStatus.trial;
    case 'EXPIRED':
      return AccountStatus.expired;
    case 'PR_ACCOUNT':
      return AccountStatus.publicRelationshipAccount;
    default:
      break;
  }
  return AccountStatus.unknown;
}

/// Converts an [AccountStatus] to a string.
String accountStatusToString(AccountStatus string) {
  switch (string) {
    case AccountStatus.premium:
      return 'PREMIUM';
    case AccountStatus.trial:
      return 'TRIAL';
    case AccountStatus.expired:
      return 'EXPIRED';
    case AccountStatus.publicRelationshipAccount:
      return 'PR_ACCOUNT';
    default:
      break;
  }
  return '';
}

DateTime _dateTimeFromTimestamp(int timestamp) {
  if (timestamp == null) return null;
  if (timestamp is int == false) return null;
  return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
}

int _dateTimeToTimestamp(DateTime datetime) {
  if (datetime == null) return 0;
  return datetime.millisecondsSinceEpoch ~/ 1000;
}

/// The status of the current access token.
///
/// See https://docs.kkbox.codes/docs/token-introspection-api
///
/// See also [TokenIntrospection].
enum AccountStatus {
  /// Indicates that the user is paying.
  premium,

  /// Indicates that the user has just registered a new account and in the free
  /// trial period.
  trial,

  /// Indicates that the account already expires and the user cannot play
  /// full-length tracks.
  expired,

  /// User for public relationship purpose. KKBOX users do not subscribe to
  /// KKBOX service, but can use same functions as premiums users.
  publicRelationshipAccount,

  /// Unknown.
  unknown,
}

/// Represents the response of [TokenIntrospectionApi].
class TokenIntrospection {
  /// Who issues the token.
  final String issuer;

  /// When will the token expire.
  final DateTime expiryDate;

  /// When was the token issued.
  final DateTime issueDate;

  /// The ID of the client that requested the access token.
  final String clientId;

  /// The permission scope of the token.
  final Set<Scope> scope;

  /// Subject of the token. it is null if the token is requested by Client
  /// Credential Flow, otherwise it will be the ID of the current user.
  final String subject;

  /// Account status of the current user.
  ///
  /// Requires [Scope.userAccountStatus].
  final AccountStatus accountStatus;

  /// If the subscription of the user will expire soon.
  ///
  /// Requires [Scope.userAccountStatus].
  final bool willExpireSoon;

  /// If the current user is a KKBOX prime user.
  ///
  /// Requires [Scope.userAccountStatus].
  final bool isPrimeMember;

  /// The territory where the current user is at.
  ///
  /// Requires [Scope.userTerritory].
  final Territory territory;

  /// Name of the current user.
  ///
  /// Requires [Scope.userProfile].
  final String username;

  TokenIntrospection({
    this.issuer,
    this.expiryDate,
    this.issueDate,
    this.clientId,
    this.scope,
    this.subject,
    this.accountStatus,
    this.willExpireSoon,
    this.isPrimeMember,
    this.territory,
    this.username,
  });

  /// Creates a new instance by a given [map].
  factory TokenIntrospection.fromMap(Map map) {
    final issuer = map['iss'];
    final expiryDate = _dateTimeFromTimestamp(map['exp']);
    final issueDate = _dateTimeFromTimestamp(map['iat']);
    final clientId = map['client_id'];
    final scope = scopesFromString(map['scope']);
    final subject = map['sub'] is String ? map['sub'] : '';
    final accountStatus = accountStatusFromString(map['account_status']);
    final willExpireSoon = map['expiring_soon'];
    final isPrimeMember = map['is_prime'];
    final territory = territoryFromString(map['territory']);
    final username = map['username'];
    return TokenIntrospection(
      issuer: issuer,
      expiryDate: expiryDate,
      issueDate: issueDate,
      clientId: clientId,
      scope: scope,
      subject: subject,
      accountStatus: accountStatus,
      willExpireSoon: willExpireSoon,
      isPrimeMember: isPrimeMember,
      territory: territory,
      username: username,
    );
  }

  /// Converts to a map representation;
  Map toMap() {
    var map = {
      'iss': issuer,
      'exp': _dateTimeToTimestamp(expiryDate),
      'iat': _dateTimeToTimestamp(issueDate),
      'client_id': clientId,
      'scope': scopesToString(scope),
      'sub': subject,
      'account_status': accountStatusToString(accountStatus),
      'expiring_soon': willExpireSoon,
      'is_prime': isPrimeMember,
      'territory': territory,
      'username': username,
    };
    return map;
  }

  /// Converts to a map representation;
  Map toJson() => toMap();
}

/// introspects an [AccessToken] and returns a copy of [TokenIntrospection].
///
/// You can use the API see if the [AccessToken] expires or not, or get
/// additional information about the current user, such as his or her user ID,
/// account expiry date and so on. Some data field required additional [Scope]
/// when you try to get an [AccessToken].
///
/// See https://docs.kkbox.codes/docs/token-introspection-api .
class TokenIntrospectionApi extends Api<TokenIntrospection> {
  /// A configuration object including client ID, client secret and environment
  /// setting.
  final ClientConfiguration configuration;

  /// The access token.
  final accessToken;

  /// Creates a new instance.
  TokenIntrospectionApi({
    @required this.accessToken,
    @required this.configuration,
  });

  @override
  Map<String, String> get customGetParameters => {
        'access_token': accessToken,
      };

  @override
  Map<String, String> get customHTTPHeaders => {
        'User-Agent': this.configuration?.userAgent ?? '',
      };

  @override
  HTTPMethod get httpMethod => HTTPMethod.get;

  @override
  String get url => 'https://account.kkbox.com/oauth2/tokeninfo';

  @override
  TokenIntrospection parseResult(String body) {
    final map = json.decode(body);
    return TokenIntrospection.fromMap(map);
  }
}
