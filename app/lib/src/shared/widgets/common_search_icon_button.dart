import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_bar_icon_buttons.dart';

class CommonSearchIconButton extends StatelessWidget {
  const CommonSearchIconButton({
    super.key,
    required this.onPressed,
    this.isSearching = false,
    this.isVisibile = true,
  });

  /// Function to execute when the search icon is pressed.
  final VoidCallback onPressed;

  /// Whether the search icon is currently active.
  /// This is used to change the icon displayed.
  final bool isSearching;

  /// Controls whether the search icon is visible or not.
  /// This is used to hide the search icon when there are no items to search.
  final bool isVisibile;

  @override
  Widget build(BuildContext context) {
    return AppBarIconButton(
      isVisibile: isVisibile,
      onPressed: onPressed,
      icon: isSearching ? Icons.search_off : Icons.search,
    );
  }
}
