import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/config/enums/form_types.dart';
import 'package:irrigazione_iot/src/features/sectors/screens/add_update_sector/add_update_sector_controller.dart';
import 'package:irrigazione_iot/src/features/sectors/screens/add_update_sector/add_update_sector_form_contents.dart';
import 'package:irrigazione_iot/src/utils/async_value_ui.dart';
import 'package:irrigazione_iot/src/shared/widgets/padded_safe_area.dart';

class AddUpdateSectorForm extends ConsumerWidget {
  const AddUpdateSectorForm({
    super.key,
    required this.formType,
    this.sectorId,
  });

  final GenericFormTypes formType;
  final String? sectorId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      addUpdateSectorControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final isLoading = ref.watch(addUpdateSectorControllerProvider).isLoading;

    return PopScope(
      canPop: !isLoading,
      onPopInvoked: (didPop) {
        if (didPop) {
          debugPrint('User exited the form');
        } else {
          debugPrint('User tried to exit the form');
        }
      },
      child: Scaffold(
          body: PaddedSafeArea(
        child: AddUpdateSectorFormContents(
          formType: formType,
          sectorId: sectorId,
        ),
      )),
    );
  }
}
