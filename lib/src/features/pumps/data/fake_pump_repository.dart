import 'package:irrigazione_iot/src/config/mock/fake_pumps.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/domain/pump.dart';
import 'package:irrigazione_iot/src/utils/delay.dart';
import 'package:irrigazione_iot/src/utils/in_memory_store.dart';

class FakePumpRepository implements PumpRepository {
  final _fakePumps = InMemoryStore<List<Pump>>(kFakePumps);

  static List<Pump> _getCompanyPumps(List<Pump> pumps, String companyId) {
    return pumps.where((pump) => pump.companyId == companyId).toList();
  }

  static Pump? _getPump(List<Pump> pumps, String pumpId) {
    try {
      return pumps.firstWhere((pump) => pump.id == pumpId);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Pump>> getCompanyPumps(String companyId) async {
    await delay(true, 8000);
    return Future.value(_getCompanyPumps(_fakePumps.value, companyId));
  }

  @override
  Stream<List<Pump>> watchCompanyPumps(String companyId) {
    return _fakePumps.stream.map((pumps) => _getCompanyPumps(pumps, companyId));
  }

  @override
  Future<Pump?> getPump(String pumpId) {
    return Future.value(_getPump(_fakePumps.value, pumpId));
  }

  @override
  Stream<Pump?> watchPump(String pumpId) {
    return _fakePumps.stream.map((pumps) => _getPump(pumps, pumpId));
  }
}
