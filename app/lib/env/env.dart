import "package:envied/envied.dart";

part 'env.g.dart';

// * To configure this, follow the following steps:
// * 1. Create a .env file in the root of the project
// * 2. Add the following environment variables:
// * SUPABASE_LOCAL_URL=your_local_url
// * SUPABASE_PROD_URL=your_prod_url
// * SUPABASE_ANON_KEY=your_anon_key
// * 3 run the generator: dart run build_runner build -d

@Envied()
final class Env {
  @EnviedField(varName: 'SUPABASE_LOCAL_URL', obfuscate: true)
  static final String supabaseLocalUrl = _Env.supabaseLocalUrl;

  @EnviedField(varName: 'SUPABASE_PROD_URL', obfuscate: true)
  static final String supabaseProdUrl = _Env.supabaseProdUrl;

  @EnviedField(varName: 'SUPABASE_ANON_KEY', obfuscate: true)
  static final String supabaseAnonKey = _Env.supabaseAnonKey;
}