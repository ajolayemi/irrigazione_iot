import 'package:irrigazione_iot/src/config/mock/fake_pumps.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';
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
  Stream<List<Pump?>> watchCompanyPumps(String companyId) {
    return _fakePumps.stream.map((pumps) => _getCompanyPumps(pumps, companyId));
  }

  @override
  Stream<Pump?> watchPump(String pumpId) {
    return _fakePumps.stream.map((pumps) => _getPump(pumps, pumpId));
  }

  @override
  Future<Pump?> createPump(Pump pump) async {
    // No validation is done here, the validation is done in the form
    await delay(addDelay);

    final lastUsedPumpId = _fakePumps.value
        .map((pump) => int.tryParse(pump.id) ?? 0)
        .reduce((maxId, currentId) => maxId > currentId ? maxId : currentId);

    final finalPump = pump.copyWith(
      id: '${lastUsedPumpId + 1}',
    );
    final currentPumps = [..._fakePumps.value];
    currentPumps.add(finalPump);
    _fakePumps.value = currentPumps;

    return Future.value(finalPump);
  }

  @override
  Future<Pump?> updatePump(Pump pump) async {
    // No validation is done here, the validation is done in the form
    await delay(addDelay);
    final currentPumps = [..._fakePumps.value];
    final pumpIndex = currentPumps.indexWhere(
      (p) => p.id == pump.id && p.companyId == pump.companyId,
    );
    if (pumpIndex >= 0) {
      currentPumps[pumpIndex] = pump;
      _fakePumps.value = currentPumps;
      return Future.value(pump);
    }
    return Future.value(null);
  }

  @override
  Stream<List<String?>> watchCompanyUsedPumpNames(String companyId) {
    return _fakePumps.stream.map(
      (pumps) => _getCompanyPumps(pumps, companyId)
          .map((pump) => pump.name.toLowerCase())
          .toList(),
    );
  }

  @override
  Future<bool> deletePump(String pumpId) async {
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

  @override
  Stream<List<String?>> watchUsedMqttMessageNames() {
    return _fakePumps.stream.map(
      (pumps) => pumps.map((pump) => pump.mqttMessageName).toList(),
    );
  }

  @override
  Stream<List<String?>> watchCompanyUsedPumpCommands(String companyId) {
    final onAndOffCommands = _getCompanyPumps(_fakePumps.value, companyId)
        .map((pump) => [pump.turnOnCommand, pump.turnOffCommand])
        .expand((element) => element)
        .toList();
    return Stream.value(onAndOffCommands);
  }
}
