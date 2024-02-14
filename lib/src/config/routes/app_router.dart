import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/go_router_refresh_stream.dart';
import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/authentication/presentation/sign_in/sign_in_screen.dart';
import 'package:irrigazione_iot/src/features/dashboard/presentation/dashboard_screen.dart';
import 'package:irrigazione_iot/src/features/home/presentation/home_nested_navigator.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/empty_placeholder_widget.dart';

// private navigator keys
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _dashboardShellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'Dashboard',
);
final _settingsShellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'Settings',
);
final _moreShellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'More',
);

/// All supported routes in the app
/// By using an enum, we can avoid using strings for route names
/// and the syntax is used
/// ```dart
/// context.goNamed(AppRoute.sampleRoute.name)
/// ```
enum AppRoute { home, signIn, settings, more }

final goRouterProvider = Provider<GoRouter>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/sign-in',
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,

    // * redirect logic based on the authentication state
    redirect: (context, state) {
      final user = authRepository.currentUser;
      final isLoggedIn = user != null;
      final path = state.uri.path;
      if (isLoggedIn && path == '/sign-in') {
        return '/'; // redirect to home page if user is logged in
      }
      if (!isLoggedIn && path != '/sign-in') {
        return '/sign-in'; // redirect to sign in page if user is not logged in
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(
      authRepository.authStateChanges(),
    ),
    routes: [
      GoRoute(
          path: '/sign-in',
          name: AppRoute.signIn.name,
          builder: (context, state) =>
              const SignInScreen() // TODO: replace with your sign in page
          ),
      // Stateful navigation based on:
      // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return HomeNestedNavigation(navigationShell: navigationShell);
        },
        branches: [
          // The dashboard branch which also serves as the app's home screen
          StatefulShellBranch(
            navigatorKey: _dashboardShellNavigatorKey,
            routes: [
              GoRoute(
                path: '/',
                name: AppRoute.home.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: DashboardScreen(),
                ), // TODO: replace with your home page
              ),
            ],
          ),

          // Settings branch
          StatefulShellBranch(
            navigatorKey: _settingsShellNavigatorKey,
            routes: [
              GoRoute(
                path: '/settings',
                name: AppRoute.settings.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  child: EmptyPlaceholderWidget(
                    message: context.loc.settingsPageTitle,
                  ),
                ), // TODO: replace with settings page
              ),
            ],
          ),

          // More branch
          // Settings branch
          StatefulShellBranch(
            navigatorKey: _moreShellNavigatorKey,
            routes: [
              GoRoute(
                path: '/more',
                name: AppRoute.more.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  child: EmptyPlaceholderWidget(
                    message: context.loc.morePageTitle,
                  ),
                ), // TODO: replace with more page
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
