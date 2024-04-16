import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:irrigazione_iot/src/app_bootstrap.dart';
import 'package:irrigazione_iot/src/app_bootstrap_fakes.dart';

// ignore:depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // turn off the # in the URLs on the web
  usePathUrlStrategy();

  // ensure URL changes in the address bar when using push / pushNamed
  // more info here: https://docs.google.com/document/d/1VCuB85D5kYxPR3qYOjVmw8boAGKb7k62heFyfFHTOvw/edit
  GoRouter.optionURLReflectsImperativeAPIs = true;

  // create an app bootstrap instance
  final appBootstrap = AppBootstrap();

  // create a container configured with all the "fake" repositories
  final container = await appBootstrap.createFakesProviderContainer();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  // use the container above to create the root widget
  final root = await appBootstrap.createRootWidget(container: container);

  // start the app
  runApp(root);
}
