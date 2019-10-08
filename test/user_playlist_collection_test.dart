import 'package:kkbox_openapi/kkbox_auth.dart';
import 'package:kkbox_openapi/kkbox_partnerapi.dart';
import 'package:test/test.dart';
import 'client_setup.dart';

void main() {
  group('Test User Playlist Collection API', () {
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
      final api = UserPlaylistCollectionApi('XZeKngaVlo4v5UjmhA',
          accessToken: accessToken, configuration: config);
      final user = await api.run();
      for (final playlist in user.data) {
        validatePlaylist(playlist);
      }
    });
  });
}
