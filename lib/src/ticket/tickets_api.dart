import 'dart:convert';

import 'package:kkbox_openapi/kkbox_auth.dart';
import 'package:meta/meta.dart';

import '../api/base.dart';
import '../api_base.dart';

/// Represents tickets.
///
/// A ticket is a media playback provision. It lets Open API client to know
/// about the playable URL of tracks.
///
/// See also [TicketsApi].
class Ticket {
  /// The URL of the playable source of a track.
  final String url;

  /// The URL of the 30-seconds audio preview a track.
  final String previewUrl;

  /// Creates a new instance.
  Ticket({this.url, this.previewUrl});

  /// Creates a new instance.
  factory Ticket.fromMap(Map<String, dynamic> jsonObject) =>
      Ticket(url: jsonObject['url'], previewUrl: jsonObject['preview_url']);
}

/// Fetches tickets.
///
/// A [Ticket] is a media playback provision. If you want to play audio files
/// from KKBOX's Open API, you need to fetch a ticket for the track at first. It
/// contains two URLs, one is for the full track, it is available when you are
/// calling the API using an access token for a premium/paying member, while
/// another one is for the short version/preview, it is merely 30 seconds long,
/// and it is available even you are calling the API using an access token for
/// an expired member.
///
/// You may encounter various errors when calling the API. For example, you may
/// encounter the "already playing on other device" error. KKBOX allows a user
/// to play audio files only on a device in the same time, so, if there is
/// already a playing device, you can not play anything until you activate the
/// current device by calling [DeviceAuthorizeApi].
///
/// You can use [CanPlayApi] to see if there is any other playing device, and
/// use [DeviceDeauthorizeApi] to notify KKBOX servers that we have stopped
/// playing on the current device as well.
///
/// The errors are including:
///
/// * HTTP 400: You need not specify desired [trackId].
/// * HTTP 403, Error Code 1: The [accessToken] is invalid.
/// * HTTP 403, Error Code 1: The track for the [trackId] is not authorized.
/// * HTTP 404: The track for the [trackId] does not exist.
/// * HTTP 403, Error Code 4: Another device is playing.
/// * HTTP 500: Server error.
///
/// See https://docs.kkbox.codes/v1.1/docs/tickets
class TicketsApi extends KKBOXBaseApi<Ticket> {
  /// ID of the track.
  String trackId;

  /// ID of the current device.
  String deviceId;

  /// Creates a new instance by passing [trackId] and [deviceId].
  TicketsApi({
    @required String accessToken,
    @required this.trackId,
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
  get postData => json.encode({'track_id': trackId, 'device_id': deviceId});

  @override
  String get url => baseUrl(configuration) + 'tickets';

  @override
  Ticket parseResult(String body) {
    final Map map = json.decode(body);
    return Ticket.fromMap(map);
  }
}
