import 'package:kkbox_openapi/kkbox_auth.dart';
import 'package:kkbox_openapi/kkbox_openapi.dart';
import 'package:test/test.dart';

import 'client_setup.dart';

void main() {
  group('Test Fetch Children Categories API', () {
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
      final api = ChildrenCategoryPlaylistsApi('0k8qLFAF8gOKR-KIdH',
          accessToken: accessToken, configuration: config);
      final playlists = await api.run();
      for (final playlist in playlists.data) {
        expect(playlist.id.isEmpty, isFalse);
        expect(playlist.title.isEmpty, isFalse);
      }
    });
  });
}
