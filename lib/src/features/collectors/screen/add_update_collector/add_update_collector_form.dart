import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/config/enums/form_types.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector.dart';
import 'package:irrigazione_iot/src/features/collectors/screen/add_update_collector/add_update_collector_form_contents.dart';

class AddUpdateCollectorForm extends ConsumerWidget {
  const AddUpdateCollectorForm({
    super.key,
    required this.formType,
    this.collectorId,
  });

  final GenericFormTypes formType;
  final CollectorID? collectorId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const isLoading = false; // todo replace this with proper state
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
        body: SafeArea(
            child: AddUpdateCollectorFormContents(
          collectorId: collectorId,
          formType: formType,
        )),
      ),
    );
  }
}
