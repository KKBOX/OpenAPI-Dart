import 'dart:convert';

import 'package:kkbox_openapi/kkbox_auth.dart';
import 'package:meta/meta.dart';

import '../api/base.dart';
import '../api_base.dart';

/// Authorizes the current device.
///
/// KKBOX allows only one device playing audio contents with the same account in
/// the same time. The API notifies the server that we want to start playing on
/// the device and asks other devices to stop.
///
/// See https://docs.kkbox.codes/v1.1/docs/device-authorize
class DeviceAuthorizeApi extends KKBOXBaseApi<void> {
  /// ID of the current device.
  String deviceId;

  /// Creates a new instance.
  DeviceAuthorizeApi({
    @required String accessToken,
    @required this.deviceId,
    ClientConfiguration configuration,
  }) : super(
          accessToken: accessToken,
          configuration: configuration,
          territory: null,
        );

  @override
  ContentType get contentType => ContentType.json;

  @override
  HTTPMethod get httpMethod => HTTPMethod.post;

  @override
  get postData => json.encode({'device_id': deviceId});

  @override
  String get url => baseUrl(configuration) + 'device-authorize';

  @override
  void parseResult(String body) {}
}
