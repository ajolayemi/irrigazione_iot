import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/config/enums/form_types.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector.dart';

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
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
