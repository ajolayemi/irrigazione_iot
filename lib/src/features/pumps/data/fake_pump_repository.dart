import 'package:irrigazione_iot/src/config/mock/fake_pumps.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';
import 'package:irrigazione_iot/src/features/user_companies/domain/company.dart';
import 'package:irrigazione_iot/src/utils/delay.dart';
import 'package:irrigazione_iot/src/utils/in_memory_store.dart';

class FakePumpRepository implements PumpRepository {
  FakePumpRepository({this.addDelay = true});
  final bool addDelay;
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
    await delay(true);
    return Future.value(_getCompanyPumps(_fakePumps.value, companyId));
  }

  @override
  Stream<List<Pump>> watchCompanyPumps(String companyId) {
    return _fakePumps.stream.map((pumps) => _getCompanyPumps(pumps, companyId));
  }

  @override
  Future<Pump?> getPump(PumpID pumpId) async {
    await delay(addDelay);
    return Future.value(_getPump(_fakePumps.value, pumpId));
  }

  @override
  Stream<Pump?> watchPump(PumpID pumpId) {
    return _fakePumps.stream.map((pumps) => _getPump(pumps, pumpId));
  }

  @override
  Future<Pump?> createPump(Pump pump, CompanyID companyId) async {
    // No validation is done here, the validation is done in the form
    await delay(addDelay);

    final lastUsedPumpId = _fakePumps.value
        .map((pump) => int.tryParse(pump.id) ?? 0)
        .reduce((maxId, currentId) => maxId > currentId ? maxId : currentId);
    
    final finalPump = pump.copyWith(
      id: '${lastUsedPumpId + 1}',
      companyId: companyId,
    );
    final currentPumps = [..._fakePumps.value];
    currentPumps.add(finalPump);
    _fakePumps.value = currentPumps;

    return Future.value(finalPump);
  }

  @override
  Future<Pump?> updatePump(Pump pump, CompanyID companyId) async {
    // No validation is done here, the validation is done in the form
    await delay(addDelay);
    final currentPumps = [..._fakePumps.value];
    final pumpIndex = currentPumps.indexWhere(
      (p) => p.id == pump.id && p.companyId == companyId,
    );
    if (pumpIndex >= 0) {
      currentPumps[pumpIndex] = pump;
      _fakePumps.value = currentPumps;
      return Future.value(pump);
    }
    return Future.value(null);
  }

  @override
  Stream<List<String?>> watchCompanyUsedPumpNames(CompanyID companyId) {
    return _fakePumps.stream.map(
      (pumps) => _getCompanyPumps(pumps, companyId)
          .map((pump) => pump.name.toLowerCase())
          .toList(),
    );
  }

  @override
  Stream<List<String?>> watchCompanyUsedPumpOffCommands(CompanyID companyId) {
    return _fakePumps.stream.map(
      (pumps) => _getCompanyPumps(pumps, companyId)
          .map((pump) => pump.commandForOff)
          .toList(),
    );
  }

  @override
  Stream<List<String?>> watchCompanyUsedPumpOnCommands(CompanyID companyId) {
    return _fakePumps.stream.map(
      (pumps) => _getCompanyPumps(pumps, companyId)
          .map((pump) => pump.commandForOn)
          .toList(),
    );
  }

  @override
  Future<bool> deletePump(PumpID pumpId) async {
    await delay(addDelay);
    final currentPumps = [..._fakePumps.value];
    final pumpIndex = currentPumps.indexWhere((p) => p.id == pumpId);
    if (pumpIndex >= 0) {
      currentPumps.removeAt(pumpIndex);
      _fakePumps.value = currentPumps;
      return Future.value(true);
    }
    return Future.value(false);
  }
}
