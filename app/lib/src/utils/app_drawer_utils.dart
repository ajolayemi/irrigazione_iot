import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_bottom_choice_sheet.dart';

class AppDrawerUtils {
  const AppDrawerUtils._();

  /// Helps in showing bottom sheet with list of items to choose from
  ///
  /// Returns the selected item index if user selects an item
  static Future<int?> showChoiceSheet({
    required BuildContext context,
    required String title,
    required List<String> items,
    required int selectedIndex,
  }) async {
    return await showModalBottomSheet<int?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      useSafeArea: true,
      enableDrag: false,
      showDragHandle: true,
      barrierColor: Colors.grey.withOpacity(0.1),
      builder: (context) => AppBottomChoiceSheet(
        title: title,
        items: items,
        selectedIndex: selectedIndex,
      ),
    );
  }
}
