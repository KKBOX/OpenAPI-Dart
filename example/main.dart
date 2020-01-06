import 'package:kkbox_openapi/kkbox_auth.dart';
import 'package:kkbox_openapi/kkbox_openapi.dart';

const clientID = 'c2330e22836b0012d2750f70dd503253';
const clientSecret = '951802f5a6caae8b5905f4b6e76a557f';

void main() async {
  final config =
      ClientConfiguration(clientId: clientID, clientSecret: clientSecret);
  final flow = ClientCredentialsFlowApi(configuration: config);
  final result = await flow.run();
  final accessToken = result.accessToken;

  final api = TrackApi('4kxvr3wPWkaL9_y3o_',
      accessToken: accessToken, configuration: config);
  final track = await api.run();
  print(track);
}
