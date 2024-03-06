import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/config/enums/form_types.dart';
import 'package:irrigazione_iot/src/features/pumps/domain/pump.dart';
import 'package:irrigazione_iot/src/features/pumps/presentation/add_pump/add_update_pump_form_content.dart';

class AddUpdatePumpForm extends StatelessWidget {
  const AddUpdatePumpForm({
    super.key,
    required this.formType,
    this.pumpId,
  });

  final GenericFormTypes formType;
  final PumpID? pumpId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AddUpdatePumpContents(
        formType: formType,
        pumpId: pumpId,
      ),
    );
  }
}
