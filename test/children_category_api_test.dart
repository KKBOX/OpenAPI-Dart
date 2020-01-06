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
      final api = ChildrenCategoryApi('Ksb_8l5NAnG7pCJEUU',
          accessToken: accessToken, configuration: config);
      final categories = await api.run();
      expect(categories.id.isEmpty, isFalse);
      expect(categories.title.isEmpty, isFalse);
      for (final category in categories.subcategories) {
        expect(category.id.isEmpty, isFalse);
        expect(category.title.isEmpty, isFalse);
      }
    });
  });
}
