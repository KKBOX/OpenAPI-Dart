/// The library handles APIs related with tickets.
///
/// A [Ticket] is a media playback provision. If you want to play audio files
/// from KKBOX's Open API, you need to fetch a ticket for the track using
/// [TicketsApi] at first. It contains two URLs, one is for the full track, it
/// is available when you are calling the API using an access token for a
/// premium/paying member, while another one is for the short version/preview,
/// it is merely 30 seconds long, and it is available even you are calling the
/// API using an access token for an expired member.
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
/// However, in real world, we seldom call [TicketsApi] in Flutter apps, since
/// Flutter is responsible for cross platform
///
/// {@category Ticket}
library kkbox_ticket;

export 'src/ticket/tickets_api.dart';
export 'src/ticket/device_authorize_api.dart';
export 'src/ticket/device_deauthorize_api.dart';
export 'src/ticket/can_play_api.dart';
