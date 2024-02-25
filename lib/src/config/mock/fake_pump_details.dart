import 'dart:math';

import 'package:irrigazione_iot/src/config/mock/fake_pumps.dart';
import 'package:irrigazione_iot/src/features/pumps/domain/pump_details.dart';

List<PumpDetails> _generateFakePumpDetails() {
  return List.generate(kFakePumps.length, (index) {
    final pump = kFakePumps[index];
    return PumpDetails(
      capacityInVolume: pump.capacityInVolume,
      commandForOff: pump.commandForOff,
      commandForOn: pump.commandForOn,
      companyId: pump.companyId,
      consumeRateInKw: pump.consumeRateInKw,
      id: pump.id,
      name: pump.name,
      totalLitresDispensed: Random().nextInt(5000), 
    );
  });
}

final kFakePumpDetails = _generateFakePumpDetails();
