import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/features/user_companies/data/user_companies_repository.dart';
import 'package:irrigazione_iot/src/widgets/app_bar_icon_buttons.dart';

class CommonAddIconButton extends ConsumerWidget {
  const CommonAddIconButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canEdit = ref.watch(companyUserRoleProvider).valueOrNull?.canEdit;
    return AppBarIconButton(
      onPressed: onPressed,
      icon: Icons.add,
      isVisibile: canEdit,
    );
  }
}