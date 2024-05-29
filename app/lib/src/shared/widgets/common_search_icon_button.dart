import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_bar_icon_buttons.dart';

class CommonSearchIconButton extends StatelessWidget {
  const CommonSearchIconButton({
    super.key,
    required this.onPressed,
    this.isSearching = false,
  });

  /// Function to execute when the search icon is pressed.
  final VoidCallback onPressed;

  /// Whether the search icon is currently active.
  /// This is used to change the icon displayed.
  final bool isSearching;

  @override
  Widget build(BuildContext context) {
    return AppBarIconButton(
      onPressed: onPressed,
      icon: isSearching ? Icons.search_off : Icons.search,
    );
  }
}
