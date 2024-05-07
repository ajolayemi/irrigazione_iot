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

    // If session is valid in and the current path is the sign in page
    if (sessionIsValid && currentPath == signInRoute) {
      // Check if user has selected a company
      final selectedCompany = selectedCompanyRepo.loadSelectedCompanyId(
        user!.uid,
      );

      if (selectedCompany != null) {
        // Redirect to home page
        return homeRoute;
      }
      return companiesListGridRoute;
    }

    // If session is not valid and the current path is not the sign in page
    if (!sessionIsValid && currentPath != signInRoute) {
      // if user is trying to sign up, let them
      if (currentPath == signUpRoute) {
        return null;
      }
      // Redirect to sign in page in every other case
      return welcomeRoute;
    }

    return null;
  }
}

@Riverpod(keepAlive: true)
RouterRedirectService routerRedirectService(RouterRedirectServiceRef ref) {
  return RouterRedirectService(ref);
}
