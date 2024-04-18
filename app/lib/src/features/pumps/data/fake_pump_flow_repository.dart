import 'package:irrigazione_iot/src/features/pumps/data/pump_flow_repository.dart';



// todo: this should access fake flow data in the future
class FakePumpFlowRepository implements PumpFlowRepository {
  FakePumpFlowRepository({this.addDelay = true});
  final bool addDelay;

  @override
  Stream<int> watchTotalLitresDispensed(String pumpId) {
    return Stream.value(0);
  }

  @override
  Stream<DateTime?> watchLastDispensation(String pumpId) {
    return Stream.value(null);
  }
}
