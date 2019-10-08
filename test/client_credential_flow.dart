import 'package:kkbox_openapi/kkbox_auth.dart';
import 'package:test/test.dart';
import 'client_setup.dart';

void main() {
  group('Test Client Credential Flow', () {
    test('First Test', () async {
      final config =
          ClientConfiguration(clientId: clientID, clientSecret: clientSecret);
      final flow = ClientCredentialsFlowApi(configuration: config);
      final result = await flow.run();
      expect(result.accessToken.isNotEmpty, isTrue);
    });
  });
}
