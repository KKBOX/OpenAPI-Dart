import 'package:kkbox_openapi/kkbox_auth.dart';
import 'package:kkbox_openapi/kkbox_openapi.dart';
import 'package:test/test.dart';

import 'client_setup.dart';

void main() {
  group('Test Album Tracks API', () {
    ClientConfiguration config;
    String accessToken;

    setUp(() async {
      config =
          ClientConfiguration(clientId: clientID, clientSecret: clientSecret);
      final flow = ClientCredentialsFlowApi(configuration: config);
      final result = await flow.run();
      accessToken = result.accessToken;
    });

    test('First Test', () async {
      final api = AlbumTracksApi('CqFUZ7AhmpvC9svIbt',
          accessToken: accessToken, configuration: config);
      final album = await api.run();
      for (var track in album.data) {
        validateTrack(track);
      }
    });
  });
}
