import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:irrigazione_iot/env/env.dart';
import 'package:irrigazione_iot/firebase_options.dart';
import 'package:irrigazione_iot/src/app_bootstrap.dart';
import 'package:irrigazione_iot/src/app_bootstrap_supabase.dart';

// ignore:depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // use local firebase functions emulator
  FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5001);

  // initialize Supabase with the local environment variables
  await Supabase.initialize(
    anonKey: Env.supabaseLocalAnonKey,
    url: Env.supabaseLocalUrlForEmulators,
    debug: true,
  );

  // turn off the # in the URLs on the web
  usePathUrlStrategy();

  // create an app bootstrap instance
  final appBootstrap = AppBootstrap();

  // create a container configured with all the Supabase repositories
  final container = await appBootstrap.createSupabaseProviderContainer();
  // use the container above to create the root widget
  final root = await appBootstrap.createRootWidget(container: container);

  // start the app
  runApp(root);
}
