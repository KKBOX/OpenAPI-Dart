/// The library contains API for partners.
///
/// Actually there are two parts of KKBOX's API for third parties. They are open
/// API and partner API. The Open API set could be accessed by anyone who
/// registers an client ID on developer.kkbox.com, while some API could be only
/// accessed by partners with agreements with KKBOX.
///
/// The partner API contains the API to access users' assets, including their
/// playlists and favorite tracks, and so on.
///
/// You can use an [AccessToken] fetched from [ClientCredentialsFlowApi] to
/// access the API that have 'User' prefix. However, you need to let the users
/// to log-in into KKBOX to acess the API with 'Me' prefix, and you need an
/// [AccessToken] from other authentication methods.
///
/// {@category API}
library kkbox_partnerapi;

export 'src/partnerapi/me_album_collection_api.dart';
export 'src/partnerapi/me_api.dart';
export 'src/partnerapi/me_daily_recommended_tracks_api.dart';
export 'src/partnerapi/me_favorite_add_api.dart';
export 'src/partnerapi/me_favorite_tracks_api.dart';
export 'src/partnerapi/me_playlist_collection_api.dart';
export 'src/partnerapi/me_private_playlist_api.dart';
export 'src/partnerapi/me_private_playlist_tracks_api.dart';
export 'src/partnerapi/me_private_playlists_api.dart';
export 'src/partnerapi/me_shared_playlists_api.dart';
export 'src/partnerapi/private_playlist.dart';
export 'src/partnerapi/user_album_collection_api.dart';
export 'src/partnerapi/user_api.dart';
export 'src/partnerapi/user_playlist_collection_api.dart';
export 'src/partnerapi/user_shared_playlists_api.dart';
