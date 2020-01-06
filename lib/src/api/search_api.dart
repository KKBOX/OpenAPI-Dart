import 'dart:convert';

import 'package:kkbox_openapi/kkbox_auth.dart';
import 'package:kkbox_openapi/kkbox_openapi_types.dart';
import 'package:meta/meta.dart';

import 'base.dart';

/// The types used in calling search API.
enum SearchType {
  /// Searches for artists.
  artist,

  /// Searches for albums.
  album,

  /// Searches for tracks.
  track,

  /// Searches for playlists.
  playlist
}

/// Converts a [SearchType] to a string.
String searchTypeToString(SearchType aType) {
  switch (aType) {
    case SearchType.artist:
      return 'artist';
    case SearchType.album:
      return 'album';
    case SearchType.track:
      return 'track';
    case SearchType.playlist:
      return 'playlist';
    default:
      break;
  }
  return null;
}

/// Searches in KKBOX.
///
/// The class helps you to search for artists, albums, tracks and playlists at
/// once. You can specify what kinds of results you want by specifying the
/// [searchTypes] parameter.
///
/// See https://docs-en.kkbox.codes/reference#search .
class SearchApi extends KKBOXBaseApi<SearchResults> {
  /// The search keyword.
  final String keyword;

  /// The desired search types.
  ///
  /// The API searches for all types when the variable is null.
  final Set<SearchType> searchTypes;

  /// The limit the amount of items in API response.
  final int limit;

  /// The offset.
  final int offset;

  /// Creates a new instance.
  SearchApi(
    this.keyword, {
    @required String accessToken,
    @required ClientConfiguration configuration,
    Territory territory = Territory.taiwan,
    this.searchTypes,
    this.limit = 50,
    this.offset = 0,
  }) : super(
          accessToken: accessToken,
          configuration: configuration,
          territory: territory,
        );

  @override
  Map<String, String> get customGetParameters {
    final searchTypes = this.searchTypes ?? SearchType.values.toSet();
    final typeString =
        searchTypes.map((x) => searchTypeToString(x)).cast<String>().join(',');
    final keyword = Uri.encodeFull(this.keyword);
    return {
      'q': keyword,
      'type': typeString,
      'territory': territoryToString(territory),
      'offset': '$offset',
      'limit': '$limit',
    };
  }

  @override
  SearchResults parseResult(String body) {
    final map = json.decode(body);
    return SearchResults(map);
  }

  @override
  String get url => baseUrl(configuration) + 'search';
}
