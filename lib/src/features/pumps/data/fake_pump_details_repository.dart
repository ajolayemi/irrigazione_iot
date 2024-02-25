import 'package:irrigazione_iot/src/config/mock/fake_pump_details.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_details_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/domain/pump.dart';
import 'package:irrigazione_iot/src/features/pumps/domain/pump_details.dart';
import 'package:irrigazione_iot/src/utils/in_memory_store.dart';

class FakePumpDetailsRepository implements PumpDetailsRepository {
  final _pumpDetails = InMemoryStore(kFakePumpDetails);

  static PumpDetails? _getPumpDetails(
      List<PumpDetails> pumpDetails, PumpID pumpId) {
    try {
      return pumpDetails.firstWhere(
        (pumpDetail) => pumpDetail.id == pumpId,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<PumpDetails?> getPumpDetails(Pump pump) {
    return Future.value(_getPumpDetails(_pumpDetails.value, pump.id));
  }

  @override
  Stream<PumpDetails?> watchPumpDetails(Pump pump) {
    return _pumpDetails.stream.map((pumpDetails) {
      return _getPumpDetails(pumpDetails, pump.id);
    });
  }
}
