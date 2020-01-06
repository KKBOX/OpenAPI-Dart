# kkbox_openapi

[![pub package](https://img.shields.io/pub/v/kkbox_openapi.svg)](https://pub.dev/packages/kkbox_openapi)
[![Actions Status](https://github.com/KKBOX//OpenAPI-Dart/workflows/Dart%20CI/badge.svg)](https://github.com/KKBOX//OpenAPI-Dart/actions)
[![License Apache](https://img.shields.io/badge/license-Apache-green.svg?style=flat)](http://www.apache.org/licenses/LICENSE-2.0)

The package implements a client to access data provided by KKBOX's Open API,
using Dart programming language. You can adopt the package to build Flutter
apps, or Dart command line tools.

## Installation

To use the SDK, add `kkbox_openapi` to your pubspec.yaml file.

Then call `pub get` or `flutter packages get`.

## Usage

Where you start is to create an instance of `ClientConfiguration`, pass your
client ID and client secret. All of the classes that do API calls in the package
require your client configuration.

```dart
var config = ClientConfiguration(
  clientId: 'YOUR_CLIENT_ID',
  clientSecret: 'CLIENT_SECRET');
```

Then you can use a method to fetch an valid `AccessToken`. For example, you can
use the client credential flow:

```dart
final config = ClientConfiguration(
  clientId: 'YOUR_CLIENT_ID',
  clientSecret: 'CLIENT_SECRET');
final flow = ClientCredentialsFlowApi(configuration: config);
final result = await flow.run();
final String accessToken = result.accessToken;
```

Then you will get an `AccessToken`, you can use it to do other API calls.

## Convention

We creates a class for each restful API endpoint. To access an API endpoint,
just create an instance of it, and then call `run()`.

The `run` method returns a
[Future](https://www.dartlang.org/tutorials/language/futures) object to fetch
data asynchronously, and it may raise errors when there are network errors, or
errors for parsing API responses. So, you may want to use try-catch while
calling these classes along with async-await keywords.

For example:

```dart
func() {
  try {
      final api = TrackApi('4kxvr3wPWkaL9_y3o_',
          accessToken: ACCESS_TOKEN, configuration: YOUR_CONFIG);
      final track = await api.run();
  } catch {
    ///...
  }
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/KKBOX/OpenAPI-Dart/issues

## License

Copyright 2018 KKBOX Technologies Limited

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
