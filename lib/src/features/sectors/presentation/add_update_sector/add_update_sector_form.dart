import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/config/enums/form_types.dart';
import 'package:irrigazione_iot/src/features/sectors/domain/sector.dart';
import 'package:irrigazione_iot/src/features/sectors/presentation/add_update_sector/add_update_sector_form_contents.dart';

class AddUpdateSectorForm extends StatelessWidget {
  const AddUpdateSectorForm({
    super.key,
    required this.formType,
    this.sectorId,
  });

  final GenericFormTypes formType;
  final SectorID? sectorId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AddUpdateSectorFormContents(
        formType: formType,
        sectorId: sectorId,
      )
    );
  }
}
