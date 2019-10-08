import 'package:kkbox_openapi/kkbox_auth.dart';
import 'package:kkbox_openapi/kkbox_openapi.dart';
import 'package:test/test.dart';
import 'client_setup.dart';

void main() {
  group('Test Playlist API', () {
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
      final api = NewReleasedAlbumsCategoryApi('0pGAIGDf5SqYh_SyHr',
          accessToken: accessToken, configuration: config);

      final category = await api.run();
      expect(category.id.isEmpty, isFalse);
      expect(category.title.isEmpty, isFalse);
      for (final album in category.albums.data) {
        validateAlbum(album);
      }
    });
  });
}
