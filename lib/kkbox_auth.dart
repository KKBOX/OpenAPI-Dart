/// The library implements various the authentication method provided by KKBOX.
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
/// {@category Authentication}
library kkbox_auth;

export 'src/auth/access_token.dart';
export 'src/auth/client_config.dart';
export 'src/auth/client_credentials_flow.dart';
