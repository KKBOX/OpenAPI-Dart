import 'package:kkbox_openapi/kkbox_auth.dart';
import 'package:kkbox_openapi/kkbox_openapi.dart';
import 'package:test/test.dart';

import 'client_setup.dart';

void main() {
  group('Test Artist Related Artists API', () {
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
      final api = ArtistRelatedArtistsApi('8q3_xzjl89Yakn_7GB',
          accessToken: accessToken, configuration: config);
      final artists = await api.run();
      for (final artist in artists.data) {
        validateArtist(artist);
      }
    });
  });
}
