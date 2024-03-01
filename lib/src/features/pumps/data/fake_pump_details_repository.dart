import 'package:irrigazione_iot/src/features/pumps/data/pump_details_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/domain/pump.dart';


// todo: this should access fake flow data in the future
class FakePumpDetailsRepository implements PumpDetailsRepository {
  FakePumpDetailsRepository({this.addDelay = true});
  final bool addDelay;

  @override
  Stream<int> watchTotalLitresDispensed(Pump pump) {
    return Stream.value(0);
  }

  }
  

