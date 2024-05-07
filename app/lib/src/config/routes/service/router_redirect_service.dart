import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/utils/extensions/supabase_auth_extensions.dart';

part 'router_redirect_service.g.dart';

/// A service class to abstract off the redirection logic
class RouterRedirectService {
  const RouterRedirectService(this._ref);
  final Ref _ref;

  static get signInRoute => AppRoute.signIn.path;
  static get homeRoute => AppRoute.home.path;
  static get companiesListGridRoute => AppRoute.companiesListGrid.path;
  static get signUpRoute => AppRoute.signUp.path;
  static get welcomeRoute => AppRoute.welcome.path;

  FutureOr<String?> redirect(
    BuildContext context,
    GoRouterState routerState,
  ) {
    final authRepo = _ref.read(authRepositoryProvider);

    final selectedCompanyRepo = _ref.read(selectedCompanyRepositoryProvider);

    // Get the current logged in user
    final user = authRepo.currentUser;

    // Check if current session is valid
    final sessionIsValid = authRepo.currentSession.isValid;

    final currentPath = routerState.uri.path;

    // Navigation rules are as follows:
    // 1. Base route is the welcome route
    // 2. If the user has a valid session,
    // if the're coming from the sign in, sign up route, redirect them to the home route
    // if they're coming from other routes, return null
    // if they haven't selected a company, they should be redirected to the companies list grid route
    // 3. If the user doesn't have a valid session
    // and they're trying to access sign up or sign in routes, they should be allowed to access them
    if (sessionIsValid) {
      final hasSelectedACompany =
          selectedCompanyRepo.loadSelectedCompanyId(user!.uid) != null;
      if (hasSelectedACompany) {
        if (currentPath == signInRoute ||
            currentPath == signUpRoute ||
            currentPath == welcomeRoute) {
          return homeRoute;
        }

        return null;
      }
      return companiesListGridRoute;
    }

    if (currentPath == signInRoute || currentPath == signUpRoute) {
      return null;
    }

    return welcomeRoute;
  }
}

@Riverpod(keepAlive: true)
RouterRedirectService routerRedirectService(RouterRedirectServiceRef ref) {
  return RouterRedirectService(ref);
}
