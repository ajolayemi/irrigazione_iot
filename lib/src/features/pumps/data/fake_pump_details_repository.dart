import 'package:irrigazione_iot/src/config/mock/fake_pump_details.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_details_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/domain/pump_details.dart';
import 'package:irrigazione_iot/src/utils/in_memory_store.dart';

class FakePumpDetailsRepository implements PumpDetailsRepository {
  final _pumpDetails = InMemoryStore(kFakePumpDetails);

  static PumpDetails? _getPumpDetails(
      List<PumpDetails> pumpDetails, String pumpId) {
    try {
      return pumpDetails.firstWhere(
        (pumpDetail) => pumpDetail.pump.id == pumpId,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<PumpDetails?> getPumpDetails(String pumpId) {
    return Future.value(_getPumpDetails(_pumpDetails.value, pumpId));
  }

  @override
  Stream<PumpDetails?> watchPumpDetails(String pumpId) {
    return _pumpDetails.stream.map((pumpDetails) {
      return _getPumpDetails(pumpDetails, pumpId);
    });
  }
}
