/// The library implements various authentication methods provided by KKBOX.
///
/// ## Client Credentials Flow
///
/// If your client does not need to access personal data such as private
/// playlists and favorite tracks (by calling API such as [MeFavoriteTracksApi]
/// and [MePrivatePlaylistsApi]), all you need to do is to have a client ID and
/// secret on developer.kkbox.com, create an instance of
/// [ClientCredentialsFlowApi], call run.
///
/// Then you can get an [AccessToken]. With the [AccessToken], you can then
/// access the data for public listing by using the API in the `kkbox_openapi`
/// library.
///
/// On the other hand, if you want to access users' personal data, you have to
/// let them to log-in into KKBOX. You may consider to use authentication code
/// flow or device code flow, but you have to ask for additional permissions
/// from KKBOX to use these flows.
///
/// ## Authentication Code Flow
///
/// Authentication code flow requires you to open a webview and direct your user
/// to the web page for logging-in, once the user logs-in into KKBOX, the web
/// page will redirect the user to a callback URL that you specify and pass you
/// an authentication code. You can use the code to fetch an [AccessToken].
///
/// Create an instance of [AuthCodeFlow], pass required parameters, then use a
/// webview to open [AuthCodeFlow.loginDialogUrl], and try to watch the change
/// of the URL of the webview and capture the authentication code, then pass the
/// code to [AuthCodeFlowTokenApi].
///
/// The packages does not handle user interface related stuff, please create
/// your own webview. It could be a little bit tricky to do this on Flutter,
/// since Flutter does not have a web view component and you may need to use
/// some Flutter plug-ins to open the native webviews to complete the process.
///
/// ## Device Code Flow
///
/// Device code flow is for clients on devices lacking of keyboard input, such
/// as smart TV. You can display a QR code on the device, and then ask the users
/// to use their smart phones to scan the QR code. It will open a webpage to let
/// users to log-in into KKBOX, and your device schedules a timer to check if
/// the user completes logging-in repeatedly.
///
/// To use device code flow, create an instance of [DeviceCodeApi]. It returns a
/// [DeviceCode], and you can now generate a QR code image from
/// [DeviceCode.verificationQRCode]. Then, create an instance of
/// [DeviceCodeFlowTokenApi] and call `run` repeatedly until it fetches an
/// [AccessToken], or the device code expires. (See [DeviceCode.expiresIn].)
///
/// ## Password Flow
///
/// You can use password flow to let users to log-in into KKBOX using a username
/// and a password. Create an instance of [PasswordFlowApi], fill-in a username
/// and a password, then call `run`.
///
/// ## Refresh and Introspects the Token
///
/// Once you have an [AccessToken], you can use [TokenRefreshingApi] to renew
/// it, or use [TokenIntrospectionApi] to introspect it.
///
/// {@category Authentication}
library kkbox_auth;

export 'src/auth/access_token.dart';
export 'src/auth/client_config.dart';
export 'src/auth/client_credentials_flow.dart';
export 'src/auth/auth_code_flow.dart';
export 'src/auth/device_code_flow.dart';
export 'src/auth/token_refreshing_api.dart';
export 'src/auth/token_introspection_api.dart';
export 'src/auth/password_flow.dart';
