import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';

import 'pump_flow_repository.dart';

// todo: this should access fake flow data in the future
class FakePumpDetailsRepository implements PumpFlowRepository {
  FakePumpDetailsRepository({this.addDelay = true});
  final bool addDelay;

  @override
  Stream<int> watchTotalLitresDispensed(Pump pump) {
    return Stream.value(0);
  }
}
