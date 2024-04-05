import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/enums/button_types.dart';
import '../features/authentication/data/auth_repository.dart';
import '../utils/extensions.dart';
import 'alert_dialogs.dart';
import 'app_cta_button.dart';

class SliverLogoutButton extends ConsumerWidget {
  const SliverLogoutButton({super.key});

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
    final loc = context.loc;
    return SliverCTAButton(
      text: loc.logOutButtonTitle,
      buttonType: ButtonType.secondary,
      onPressed: () => _signOut(context, ref),
    );
  }
}
