import 'package:kkbox_openapi/kkbox_auth.dart';
import 'package:kkbox_openapi/kkbox_openapi.dart';
import 'package:test/test.dart';

import 'client_setup.dart';

void main() {
  group('Test Search API', () {
    ClientConfiguration config;
    String accessToken;

    setUp(() async {
      config =
          ClientConfiguration(clientId: clientID, clientSecret: clientSecret);
      final flow = ClientCredentialsFlowApi(configuration: config);
      final result = await flow.run();
      accessToken = result.accessToken;
    });
    test('Search Track', () async {
      try {
        final api = SearchApi('Jay Chou',
            configuration: config,
            accessToken: accessToken,
            searchTypes: {SearchType.track});
        final results = await api.run();
        expect(results.trackResults != null, isTrue);
        expect(results.artistResults == null, isTrue);
        expect(results.playlistResults == null, isTrue);
        expect(results.albumResults == null, isTrue);
        expect(results.trackResults.data.isEmpty, isFalse);
        for (final track in results.trackResults.data) {
          validateTrack(track);
        }
      } catch (err) {
        fail(err.toString());
      }
    });

    test('Search Artist', () async {
      try {
        final api = SearchApi('周杰倫',
            configuration: config,
            accessToken: accessToken,
            searchTypes: {SearchType.artist});
        final results = await api.run();

        expect(results.trackResults == null, isTrue);
        expect(results.artistResults != null, isTrue);
        expect(results.playlistResults == null, isTrue);
        expect(results.albumResults == null, isTrue);
        expect(results.artistResults.data.isEmpty, isFalse);
        for (final artist in results.artistResults.data) {
          validateArtist(artist);
        }
      } catch (err) {
        fail(err.toString());
      }
    });

    test('Search Album', () async {
      try {
        final api = SearchApi('Jay Chou',
            configuration: config,
            accessToken: accessToken,
            searchTypes: {SearchType.album});
        final results = await api.run();

        expect(results.trackResults == null, isTrue);
        expect(results.artistResults == null, isTrue);
        expect(results.playlistResults == null, isTrue);
        expect(results.albumResults != null, isTrue);
        for (final album in results.albumResults.data) {
          validateAlbum(album);
        }
      } catch (err) {
        fail(err.toString());
      }
    });

    test('Search Playlist', () async {
      try {
        final api = SearchApi('周杰倫',
            configuration: config,
            accessToken: accessToken,
            searchTypes: {SearchType.playlist});
        final results = await api.run();

        expect(results.trackResults == null, isTrue);
        expect(results.artistResults == null, isTrue);
        expect(results.playlistResults != null, isTrue);
        expect(results.albumResults == null, isTrue);
        for (final playlist in results.playlistResults.data) {
          validatePlaylist(playlist);
        }
      } catch (err) {
        fail(err.toString());
      }
    });
  });
}
