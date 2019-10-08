import 'package:kkbox_openapi/kkbox_auth.dart';
import 'package:kkbox_openapi/kkbox_openapi.dart';
import 'package:test/test.dart';
import 'client_setup.dart';

void main() {
  group('Test Playlist Tracks API', () {
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
      final api = PlaylistTracksApi('OsyceCHOw-NvK5j6Vo',
          accessToken: accessToken, configuration: config);
      final playlist = await api.run();
      for (final track in playlist.data) {
        validateTrack(track);
      }
    });
  });
}
