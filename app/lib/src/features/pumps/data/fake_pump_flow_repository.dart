import 'package:irrigazione_iot/src/features/pumps/data/pump_flow_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';



// todo: this should access fake flow data in the future
class FakePumpFlowRepository implements PumpFlowRepository {
  FakePumpFlowRepository({this.addDelay = true});
  final bool addDelay;

  @override
  Stream<int> watchTotalLitresDispensed(Pump pump) {
    return Stream.value(0);
  }
}