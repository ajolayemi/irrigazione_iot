import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/dashboard/screens/dashboard_screen_contents.dart';
import 'package:irrigazione_iot/src/shared/widgets/alert_dialogs.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/shared/widgets/padded_safe_area.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  // TODO avoid repeating this function as the same function is in more_options_screen_contents.dart
  Future<bool> _showSignOutDialog(BuildContext context) async {
    final loc = context.loc;
    return await showAlertDialog(
            context: context,
            title: loc.logOutAlertDialogTitle,
            content: loc.logOutAlertDialogContent,
            cancelActionText: loc.alertDialogCancel,
            defaultActionText: loc.logOutAlertDialogConfirm) ??
        false;
  }

  void _signOut(BuildContext context, WidgetRef ref) async {
    if (await _showSignOutDialog(context)) {
      ref.read(authRepositoryProvider).signOut();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authRepositoryProvider).currentUser;

    return Scaffold(
      body: PaddedSafeArea(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
        child: CustomScrollView(
          slivers: <Widget>[
            AppSliverBar(
              title: context.loc.welcome(user?.name ?? ''),
              actions: [
                // Icon button to select a new company
                IconButton(
                  icon: const Icon(Icons.business),
                  onPressed: () {
                    context.pushNamed(
                      AppRoute.companiesListGrid.name,
                    );
                  },
                ),
                // Icon button to logout
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () => _signOut(context, ref),
                ),
              ],
            ),
            const DashboardScreenContents(),
          ],
        ),
      ),
    );
  }
}
