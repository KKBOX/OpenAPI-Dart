import 'package:kkbox_openapi/kkbox_openapi_types.dart';
import 'package:test/test.dart';

const clientID = "c2330e22836b0012d2750f70dd503253";
const clientSecret = "951802f5a6caae8b5905f4b6e76a557f";

validateArtist(ArtistInfo artist) {
  expect(artist.id.isEmpty, isFalse);
  expect(artist.name.isEmpty, isFalse);
  expect(artist.url.isEmpty, isFalse);
}

validateAlbum(AlbumInfo album) {
  expect(album.id.isEmpty, isFalse);
  expect(album.name.isEmpty, isFalse);
  expect(album.url.isEmpty, isFalse);
  if (album.artist != null) {
    validateArtist(album.artist);
  }
}

validateTrack(TrackInfo track) {
  expect(track.id.isEmpty, isFalse);
  expect(track.name.isEmpty, isFalse);
  expect(track.url.isEmpty, isFalse);
  expect(track.duration > 0, isTrue);
  if (track.album != null) {
    validateAlbum(track.album);
  }
}

validatePlaylist(PlaylistInfo playlist) {
  expect(playlist.id.isEmpty, isFalse);
  expect(playlist.title.isEmpty, isFalse);
  expect(playlist.url.isEmpty, isFalse);
  if (playlist.tracks != null) {
    for (final track in playlist.tracks.data) {
      validateTrack(track);
    }
  }
}
