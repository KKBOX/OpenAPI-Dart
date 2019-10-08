import 'package:kkbox_openapi/kkbox_auth.dart';
import 'package:meta/meta.dart';

import '../api_base.dart';

String baseUrl(ClientConfiguration configuration) {
  if (configuration?.environment == Environment.staging) {
    return 'https://api.kkbox-staging.com/v1.1/';
  }
  return 'https://api.kkbox.com/v1.1/';
}

/// Converts a string to a [Territory].
Territory territoryFromString(String s) {
  switch (s) {
    case 'TW':
      return Territory.taiwan;
    case 'HK':
      return Territory.hongkong;
    case 'SG':
      return Territory.singapore;
    case 'MY':
      return Territory.malaysia;
    case 'JP':
      return Territory.japan;
    default:
      break;
  }
  return null;
}

/// Converts a [Territory] to a string.
String territoryToString(Territory territory) {
  switch (territory) {
    case Territory.taiwan:
      return 'TW';
    case Territory.hongkong:
      return 'HK';
    case Territory.singapore:
      return 'SG';
    case Territory.malaysia:
      return 'MY';
    case Territory.japan:
      return 'JP';
    default:
      break;
  }
  return 'TW';
}

/// A base of API used in KKBOX's Open API.
abstract class KKBOXBaseApi<T> extends Api<T> {
  /// The access token.
  final String accessToken;

  /// A configuration object including client ID, client secret and environment
  /// setting.
  final ClientConfiguration configuration;

  /// The desired territory.
  Territory territory = Territory.taiwan;

  /// Creates a new instance.
  KKBOXBaseApi({
    @required this.accessToken,
    @required this.configuration,
    this.territory = Territory.taiwan,
  });

  @override
  Map<String, String> get customHTTPHeaders => {
        'User-Agent': configuration?.userAgent ?? '',
        'Authorization': 'Bearer ' + accessToken,
      };

  @override
  HTTPMethod get httpMethod => HTTPMethod.get;
}

/// The territory where KKBOX provides services.
///
/// Since KKBOX provides services in different territories and curated contents
/// in these territories vary, you can specify the territory parameter while
/// doing an API call in order to ask the API to return the contents matching to
/// the territory.
enum Territory {
  /// Taiwan
  taiwan,

  /// Hong-Kong
  hongkong,

  /// Singapore
  singapore,

  /// Malaysia
  malaysia,

  /// Japan
  japan
}
