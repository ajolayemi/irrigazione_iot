import 'package:irrigazione_iot/src/config/mock/fake_pumps.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/domain/pump.dart';
import 'package:irrigazione_iot/src/utils/in_memory_store.dart';

class FakePumpRepository implements PumpRepository {
  final _fakePumps = InMemoryStore<List<Pump>>(kFakePumps);

  static Pump? _getPump(List<Pump> pumps, String pumpId) {
    try {
      return pumps.firstWhere((pump) => pump.id == pumpId);
    } catch (e) {
      return null;
    }
  }

  static List<Pump> _getCompanyPumps(List<Pump> pumps, String companyId) {
    return pumps.where((pump) => pump.companyId == companyId).toList();
  }

  @override
  Future<List<Pump>> getCompanyPumps(String companyId) {
    return Future.value(_getCompanyPumps(_fakePumps.value, companyId));
  }

  @override
  Future<bool> getPumpStatus(String pumpId) {
    // TODO: implement getPumpStatus
    throw UnimplementedError();
  }

  @override
  Future<void> togglePumpStatus(String pumpId, bool status) {
    return Future.value();
  }

  @override
  Stream<List<Pump>> watchCompanyPumps(String companyId) {
    return _fakePumps.stream.map((pumps) => _getCompanyPumps(pumps, companyId));
  }

  // todo change this so that it checks pump status from flow
  @override
  Stream<bool> watchPumpStatus(String pumpId) {
    final pump = _getPump(_fakePumps.value, pumpId);
    if (pump == null) {
      return Stream.value(false);
    } else {
      return Stream.value(true);
    }
  }
}
