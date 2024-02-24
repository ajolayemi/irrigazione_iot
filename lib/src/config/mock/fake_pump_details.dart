import 'dart:math';

import 'package:irrigazione_iot/src/config/mock/fake_pumps.dart';
import 'package:irrigazione_iot/src/features/pumps/domain/pump_details.dart';

List<PumpDetails> _generateFakePumpDetails() {
  return List.generate(
    kFakePumps.length,
    (index) => PumpDetails(
      pump: kFakePumps[index],
      totalLitresDispensed: Random().nextInt(5000),
      lastDispensation: DateTime.now().subtract(
        Duration(days: Random().nextInt(30)),
      ),
    ),
  );
}

final kFakePumpDetails = _generateFakePumpDetails();
