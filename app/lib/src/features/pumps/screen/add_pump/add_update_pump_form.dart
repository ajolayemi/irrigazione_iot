import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/enums/form_types.dart';
import '../../model/pump.dart';
import 'add_update_pump_controller.dart';
import 'add_update_pump_form_content.dart';
import '../../../../utils/async_value_ui.dart';
import '../../../../widgets/padded_safe_area.dart';

class AddUpdatePumpForm extends ConsumerWidget {
  const AddUpdatePumpForm({
    super.key,
    required this.formType,
    this.pumpId,
  });

  final GenericFormTypes formType;
  final PumpID? pumpId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      addUpdatePumpControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final isLoading = ref.watch(addUpdatePumpControllerProvider).isLoading;
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
          child: AddUpdatePumpContents(
            formType: formType,
            pumpId: pumpId,
          ),
        ),
      ),
    );
  }
}
