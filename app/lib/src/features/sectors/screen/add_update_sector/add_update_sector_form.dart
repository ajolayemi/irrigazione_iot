import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/enums/form_types.dart';
import '../../model/sector.dart';
import 'add_update_sector_controller.dart';
import 'add_update_sector_form_contents.dart';
import '../../../../utils/async_value_ui.dart';
import '../../../../widgets/padded_safe_area.dart';

class AddUpdateSectorForm extends ConsumerWidget {
  const AddUpdateSectorForm({
    super.key,
    required this.formType,
    this.sectorId,
  });

  final GenericFormTypes formType;
  final SectorID? sectorId;

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
        )
      ),
    );
  }
}
