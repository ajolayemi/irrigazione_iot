import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/app_bootstrap.dart';
import 'package:irrigazione_iot/src/app_bootstrap_supabase.dart';

// ignore:depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: initialize supabase here

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
