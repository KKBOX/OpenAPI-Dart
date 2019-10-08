# kkbox_openapi

[![pipeline status](https://gitlab.kkinternal.com/xddd/kkbox_openapi_dart/badges/master/pipeline.svg)](https://gitlab.kkinternal.com/xddd/kkbox_openapi_dart/commits/master) | [![coverage report](https://gitlab.kkinternal.com/xddd/kkbox_openapi_dart/badges/master/coverage.svg)](https://gitlab.kkinternal.com/xddd/kkbox_openapi_dart/commits/master)

The package implements a client to access data provided by KKBOX's Open and
Partner API, using Dart programming language. You can adopt the package to build
Flutter apps, or Dart command line tools.

## Installation

Please add the following lines to your `pubspec.yaml` file.

```yaml
dependencies:
  kkbox_openapi:
    git: "git@gitlab.kkinternal.com:xddd/kkbox_openapi_dart.git"
```

Then call `pub get` or `flutter packages get`.

## Usage

The packages contained classes for not only Open API but also Patner API, and
make them into two libraries, 'kkbox_openapi' and 'kkbox_partner'.

However, no matter what kind of app you want to create, you need to set up a
basic client configuration, and you may want an access token for the users. You
can do it with the 'kkbox_auth' library.

Where you will start from is to create an instance of `ClientConfiguration`,
pass your client ID and client secret. All of the classes that do API calls in
the package require your client configuration.

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

## Documentation

Please visit https://xddd.kkbox.io/kkbox_openapi_dart/ .

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://gitlab.kkinternal.com/xddd/kkbox_openapi_dart
