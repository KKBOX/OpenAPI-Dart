/// The library implements a client for KKBOX's Open API.
///
/// Most of these API are for basic metadata and public listing, such as
/// metadata about tracks, albums, artists and playlists.
///
/// To access these API, you need a valid [AccessToken]. To learn about how to
/// obtain an [AccessToken], please take a look at the `kkbox_auth` library.
///
/// While calling these API, you should also pass a territory code. KKBOX
/// presents localized data in different territories. For example, a Japanese
/// track maybe titled in Japanese in Japan, but it might be titled in
/// Traditional Chinese in Taiwan and Simplified Chinese in Singapore.
///
/// However, KKBOX's Open API does not help you to do Chinese conversion on the
/// title and description of playlists. If you want the users in Singapore to
/// read contents in Simplified Chinese, you have to do Chinese conversion by
/// your self.
///
/// {@category API}
library kkbox_openapi;

export 'src/api/album_api.dart';
export 'src/api/album_tracks_api.dart';
export 'src/api/artist_albums_api.dart';
export 'src/api/artist_api.dart';
export 'src/api/artist_releated_artists_api.dart';
export 'src/api/artist_top_tracks_api.dart';
export 'src/api/base.dart';
export 'src/api/charts_api.dart';
export 'src/api/children_categories_api.dart';
export 'src/api/children_category_api.dart';
export 'src/api/children_category_playlists_api.dart';
export 'src/api/featured_playlist_categories_api.dart';
export 'src/api/featured_playlist_category_api.dart';
export 'src/api/featured_playlists_api.dart';
export 'src/api/genre_station_api.dart';
export 'src/api/genre_stations_api.dart';
export 'src/api/mood_station_api.dart';
export 'src/api/mood_stations_api.dart';
export 'src/api/new_hits_playlists_api.dart';
export 'src/api/new_release_albums_categories_api.dart';
export 'src/api/new_release_albums_category_api.dart';
export 'src/api/playlist_api.dart';
export 'src/api/playlist_tracks_api.dart';
export 'src/api/search_api.dart';
export 'src/api/track_api.dart';
