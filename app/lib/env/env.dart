import "package:envied/envied.dart";

part 'env.g.dart';

// * To configure this, follow the following steps:
// * 1. Create a .env file in the root of the project
// * 2. Add the following environment variables:
// * SUPABASE_LOCAL_URL=your_local_url
// * SUPABASE_PROD_URL=your_prod_url
// * SUPABASE_ANON_KEY=your_anon_key
// * 3 run the generator: dart run build_runner build -d

@Envied(path: '../.env')
final class Env {
  /// When developing and testing locally using emulators
  /// the supabase url used has the default localhost and
  /// port provided by supabase in its documentation
  static get supabaseLocalUrlForEmulators =>
      'http://$supabaseDefaultLocalHost:$supabaseLocalDevPort';

  /// When developing and testing locally using a real device
  /// the localhost for the supabase url is different because
  /// supabase services such as authentication won't work with
  /// the default localhost (127.0.0.1) provided by supabase
  /// in its documentation
  static get supabaseLocalUrlForRealDevice =>
      'http://$localhost:$supabaseLocalDevPort';

  @EnviedField(varName: 'LOCALHOST', obfuscate: true, defaultValue: 'localhost')
  static final String localhost = _Env.localhost;

  @EnviedField(
    varName: 'SUPABASE_DEFAULT_LOCALHOST',
    obfuscate: true,
    defaultValue: 'localhost',
  )
  static final String supabaseDefaultLocalHost = _Env.supabaseDefaultLocalHost;

  @EnviedField(
    varName: 'SUPABASE_LOCAL_DEV_PORT',
    obfuscate: true,
    defaultValue: '3000',
  )
  static final String supabaseLocalDevPort = _Env.supabaseLocalDevPort;

  @EnviedField(
    varName: 'SUPABASE_LOCAL_URL',
    obfuscate: true,
    defaultValue: 'http://localhost:3000',
  )
  static final String supabaseLocalUrl = _Env.supabaseLocalUrl;

  @EnviedField(
    varName: 'SUPABASE_PROD_URL',
    obfuscate: true,
    defaultValue: 'https://your_prod_url.com',
  )
  static final String supabaseProdUrl = _Env.supabaseProdUrl;

  @EnviedField(
    varName: 'SUPABASE_PROD_ANON_KEY',
    obfuscate: true,
    defaultValue: 'your_prod_anon_key',
  )
  static final String supabaseProdAnonKey = _Env.supabaseProdAnonKey;

  @EnviedField(
    varName: 'SUPABASE_LOCAL_ANON_KEY',
    obfuscate: true,
    defaultValue: 'your_local_anon_key',
  )
  static final String supabaseLocalAnonKey = _Env.supabaseLocalAnonKey;

  @EnviedField(
    varName: 'IOS_CLIENT_ID',
    obfuscate: true,
    defaultValue: 'your_ios_client_id',
  )
  static final String iosClientId = _Env.iosClientId;

  @EnviedField(
    varName: 'WEB_CLIENT_ID',
    obfuscate: true,
    defaultValue: 'your_web_client_id',
  )
  static final String webClientId = _Env.webClientId;

  @EnviedField(
    varName: 'ANDROID_CLIENT_ID',
    obfuscate: true,
    defaultValue: 'your_android_client_id',
  )
  static final String androidClientId = _Env.androidClientId;
}
