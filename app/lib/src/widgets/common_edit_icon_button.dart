import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/features/company_users/data/company_users_repository.dart';
import 'package:irrigazione_iot/src/widgets/app_bar_icon_buttons.dart';

class CommonEditIconButton extends ConsumerWidget {
  const CommonEditIconButton({
    super.key,
    required this.onPressed,
    this.alternateIsVisible,
  });

  final VoidCallback onPressed;

  /// If the button should be visible or not
  /// if not provided, the generic canEdit check on user role is used
  final bool? alternateIsVisible;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canEdit = ref.watch(companyUserRoleProvider).valueOrNull?.canEdit;
    return AppBarIconButton(
      onPressed: onPressed,
      icon: Icons.edit,
      isVisibile: alternateIsVisible ?? canEdit,
    );
  }
}
