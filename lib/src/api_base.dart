import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import './types/errors.dart';

abstract class Api<ResultType> {
  /// Content type of the API call.
  ///
  /// Subclasses should override it.
  ContentType get contentType => ContentType.wwwFormUrlencoded;

  /// A list of custom GET parameters.
  ///
  /// Subclasses should override it.
  Map<String, String> get customGetParameters => {};

  /// Custom HTTP headers.
  ///
  /// Subclasses could override it.
  Map<String, String> get customHTTPHeaders => {};

  /// HTTP method used in the API.
  ///
  /// It could be GET, POST, PUT, PATCH, or DELETE.
  HTTPMethod get httpMethod;

  /// Data for doing POST calls.Subclasses should override it.
  dynamic get postData => null;

  /// Endpoint of the API.
  ///
  /// Subclasses should override it.
  String get url;

  Future<ResultType> handleResponse(http.Response response) async {
    var statusCode = response.statusCode;
    if (statusCode >= 300 || statusCode < 200) {
      switch (statusCode) {
        case 401:
          throw UnauthorizedException();
        case 403:
          throw ForbiddenException();
        case 404:
          throw NotFoundException();
        default:
          throw Exception(
              'Request fail with status code $statusCode \nMessage: ${response.body}');
      }
    }
    var body = utf8.decode(response.bodyBytes);
    return parseResult(body);
  }

  /// How an API convert HTTP responses to model objects.
  ///
  /// Subclasses should override it.
  ResultType parseResult(String body);

  /// Fire the API call.
  Future<ResultType> run() async {
    http.Response response;
    Map<String, String> headers = {};
    final url = _urlByAppendingStandardParameters();
    headers.addAll(customHTTPHeaders);

    switch (httpMethod) {
      case HTTPMethod.get:
        response = await http.get(url, headers: headers);
        break;
      case HTTPMethod.post:
        switch (contentType) {
          case ContentType.json:
            headers['Content-Type'] = 'application/json';
            break;
          case ContentType.wwwFormUrlencoded:
            headers['Content-Type'] = 'application/x-www-form-urlencoded';
            break;
        }
        response = await http.post(url, body: postData, headers: headers);
        break;
      case HTTPMethod.put:
        response = await http.put(url, body: postData, headers: headers);
        break;
      case HTTPMethod.patch:
        response = await http.patch(url, body: postData, headers: headers);
        break;
      case HTTPMethod.delete:
        response = await http.delete(url, headers: headers);
        break;
      default:
        break;
    }
    if (response == null) {
      throw StateError("No response.");
    }
    return await handleResponse(response);
  }

  String _urlByAppendingStandardParameters() {
    String baseUrl = url;
    baseUrl += baseUrl.contains('?') ? '&' : '?';
    Map<String, String> parameters = {};
    parameters.addAll(customGetParameters);
    return baseUrl +
        parameters.keys
            .map<String>((k) =>
                '${Uri.encodeComponent(k)}=${Uri.encodeComponent(parameters[k])}')
            .join('&');
  }
}

enum ContentType { json, wwwFormUrlencoded }

/// The HTTP method used in an API call.
enum HTTPMethod { get, post, put, patch, delete }
