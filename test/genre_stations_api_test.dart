import 'package:kkbox_openapi/kkbox_auth.dart';
import 'package:kkbox_openapi/kkbox_openapi.dart';
import 'package:test/test.dart';
import 'client_setup.dart';

void main() {
  group('Test Mood Station API', () {
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
      final api =
          GenreStationsApi(accessToken: accessToken, configuration: config);
      final stations = await api.run();
      for (final station in stations.data) {
        expect(station.id.isEmpty, isFalse);
        expect(station.name.isEmpty, isFalse);
      }
    });
  });
}
