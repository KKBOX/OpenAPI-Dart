import 'dart:convert';

import 'package:meta/meta.dart';

import '../api_base.dart';
import 'access_token.dart';
import 'client_config.dart';

/// Represents a device code in device code flow.
///
/// You can use [DeviceCodeApi] to fetch a device code.
class DeviceCode {
  /// The QR code.
  final String verificationQRCode;

  /// The short verification URL.
  final String shortVerificationURL;

  /// The verification URL.
  final String verificationURL;

  /// The user code.
  final String userCode;

  /// The interval to call the server.
  final int interval;

  /// When will the device code expire.
  final int expiresIn;

  /// The device code.
  final String deviceCode;

  /// Creates a new instance.
  DeviceCode({
    this.verificationQRCode,
    this.shortVerificationURL,
    this.verificationURL,
    this.userCode,
    this.interval,
    this.expiresIn,
    this.deviceCode,
  });

  /// Creates a new instance from a given [map].
  factory DeviceCode.fromMap(Map map) => DeviceCode(
        deviceCode: map['device_code'],
        shortVerificationURL: map['short_verification_url'],
        verificationURL: map['verification_url'],
        verificationQRCode: map['verification_qrcode'],
        interval: map['interval'],
        expiresIn: map['expires_in'],
        userCode: map['user_code'],
      );
}

/// Fetches a [DeviceCode].
///
/// Once you get a [DeviceCode], generate a QR Code image of
/// [DeviceCode.verificationQRCode], present it on screen, and schedule a timer
/// to call [DeviceCodeFlowTokenApi].
///
/// See https://docs.kkbox.codes/docs/oauth2-token-api-devices-flow .
class DeviceCodeApi extends Api<DeviceCode> {
  /// A configuration object including client ID, client secret and environment
  /// setting.
  final ClientConfiguration configuration;

  /// Creates a new instance.
  DeviceCodeApi({
    @required this.configuration,
  });

  @override
  ContentType get contentType => ContentType.wwwFormUrlencoded;

  @override
  HTTPMethod get httpMethod => HTTPMethod.post;

  @override
  get postData => {
        'client_id': this.configuration.clientId,
        'scope': scopesToString(this.configuration.scope),
      };

  @override
  String get url => 'https://account.kkbox.com/oauth2/device/code';

  @override
  DeviceCode parseResult(String body) {
    final map = json.decode(body);
    return DeviceCode.fromMap(map);
  }
}

/// Fetches an [AccessToken] by giving a [deviceCode].
///
/// You may call the API repeatedly until it returns an [AccessToken], or until
/// the device code expires.
///
/// See https://docs.kkbox.codes/docs/oauth2-token-api-devices-flow .
class DeviceCodeFlowTokenApi extends Api<AccessToken> {
  /// A configuration object including client ID, client secret and environment
  /// setting.
  final ClientConfiguration configuration;

  /// The deviceCode.
  final deviceCode;

  /// Creates a new instance.
  DeviceCodeFlowTokenApi({
    @required this.deviceCode,
    @required this.configuration,
  });

  @override
  ContentType get contentType => ContentType.wwwFormUrlencoded;

  @override
  HTTPMethod get httpMethod => HTTPMethod.post;

  @override
  get postData => {
        'grant_type': 'http://oauth.net/grant_type/device/1.0',
        'client_id': this.configuration.clientId,
        'client_secret': this.configuration.clientSecret,
        'code': this.deviceCode,
      };

  @override
  String get url => 'https://account.kkbox.com/oauth2/token';

  @override
  AccessToken parseResult(String body) {
    final map = json.decode(body);
    return AccessToken.fromMap(map);
  }
}
