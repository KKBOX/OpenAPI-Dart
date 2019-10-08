import 'package:kkbox_openapi/kkbox_auth.dart';
import 'package:kkbox_openapi/kkbox_openapi.dart';
import 'package:test/test.dart';

import 'client_setup.dart';

void main() {
  group('Test Artist Albums API', () {
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
      final api = ArtistAlbumsApi('8q3_xzjl89Yakn_7GB',
          accessToken: accessToken, configuration: config);
      final albums = await api.run();
      for (var album in albums.data) {
        validateAlbum(album);
      }
    });
  });
}
