import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/authentication/role_management/data/role_management_repository.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_bar_icon_buttons.dart';

class CommonAddIconButton extends ConsumerWidget {
  const CommonAddIconButton({
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
    final canEdit = ref.watch(userCanCreateStreamProvider).valueOrNull ?? false;
    return AppBarIconButton(
      onPressed: onPressed,
      icon: Icons.add,
      isVisibile: alternateIsVisible ?? canEdit,
    );
  }
}
