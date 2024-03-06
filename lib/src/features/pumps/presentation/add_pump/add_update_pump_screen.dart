import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/config/enums/form_types.dart';
import 'package:irrigazione_iot/src/features/pumps/domain/pump.dart';
import 'package:irrigazione_iot/src/features/pumps/presentation/add_pump/add_update_pump_screen_content.dart';

class AddAndCreatePumpScreen extends StatelessWidget {
  const AddAndCreatePumpScreen({
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
