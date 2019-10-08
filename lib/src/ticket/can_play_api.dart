import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kkbox_openapi/kkbox_auth.dart';
import 'package:meta/meta.dart';

import '../api/base.dart';
import '../api_base.dart';

/// Checks if we can play on the current device.
///
/// See https://docs.kkbox.codes/v1.1/docs/canplay
class CanPlayApi extends KKBOXBaseApi<bool> {
  /// ID of the current device.
  String deviceId;

  /// Creates a new instance.
  CanPlayApi({
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
  String get url => baseUrl(configuration) + 'canplay';

  @override
  Future<bool> handleResponse(http.Response response) async {
    var statusCode = response.statusCode;
    if (statusCode != 200) {
      return false;
    }
    return true;
  }

  @override
  bool parseResult(String body) {
    return true;
  }
}
