import 'package:kkbox_openapi/kkbox_auth.dart';
import 'package:kkbox_openapi/kkbox_partnerapi.dart';
import 'package:test/test.dart';
import 'client_setup.dart';

void main() {
  group('Test User API', () {
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
      final api = UserApi('XZeKngaVlo4v5UjmhA',
          accessToken: accessToken, configuration: config);
      final user = await api.run();
      expect(user.id.isEmpty, isFalse);
      expect(user.name.isEmpty, isFalse);
    });
  });
}
