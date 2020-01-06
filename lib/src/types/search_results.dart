import 'album.dart';
import 'artist.dart';
import 'paging_info.dart';
import 'playlist.dart';
import 'summary.dart';
import 'track.dart';

/// Represents the results of search API.
class SearchResults {
  /// The found tracks.
  TrackList trackResults;

  /// The found albums.
  AlbumList albumResults;

  /// The found artists,
  ArtistList artistResults;

  /// The found playlists.
  PlaylistList playlistResults;

  /// The paging informaion.
  PagingInfo paging;

  /// The summary.
  Summary summary;

  /// Creates a new instance.
  SearchResults(Map<String, dynamic> jsonObject) {
    if (jsonObject['tracks'] != null) {
      trackResults = TrackList(jsonObject['tracks']);
    }
    if (jsonObject['albums'] != null) {
      albumResults = AlbumList(jsonObject['albums']);
    }
    if (jsonObject['artists'] != null) {
      artistResults = ArtistList(jsonObject['artists']);
    }
    if (jsonObject['playlists'] != null) {
      playlistResults = PlaylistList(jsonObject['playlists']);
    }
    paging = PagingInfo(jsonObject['paging']);
    summary = Summary(jsonObject['summary']);
  }

  Map<String, dynamic> toJson() {
    Map json = <String, dynamic>{};
    if (trackResults != null) json['tracks'] = trackResults.toJson();
    if (albumResults != null) json['albums'] = albumResults.toJson();
    if (artistResults != null) json['artists'] = artistResults.toJson();
    if (playlistResults != null) json['playlists'] = playlistResults.toJson();

    json['paging'] = paging.toJson();
    json['summary'] = summary.toJson();
    return json;
  }
}
