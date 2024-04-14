import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/config/enums/form_types.dart';
import 'package:irrigazione_iot/src/features/collectors/screen/add_update_collector/add_update_collector_controller.dart';
import 'package:irrigazione_iot/src/features/collectors/screen/add_update_collector/add_update_collector_form_contents.dart';
import 'package:irrigazione_iot/src/widgets/padded_safe_area.dart';

class AddUpdateCollectorForm extends ConsumerWidget {
  const AddUpdateCollectorForm({
    super.key,
    required this.formType,
    this.collectorId,
  });

  final GenericFormTypes formType;
  final String? collectorId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(addUpdateCollectorControllerProvider).isLoading;
    return PopScope(
      canPop: !isLoading,
      onPopInvoked: (didPop) {
        if (didPop) {
          debugPrint('User exited COLLECTOR form');
        } else {
          debugPrint('User tried to exit COLLECTOR form');
        }
      },
      child: Scaffold(
        body: PaddedSafeArea(
            child: AddUpdateCollectorFormContents(
          collectorId: collectorId,
          formType: formType,
        )),
      ),
    );
  }
}
