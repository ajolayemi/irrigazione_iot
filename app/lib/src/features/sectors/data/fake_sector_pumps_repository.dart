import 'package:collection/collection.dart';
import 'package:irrigazione_iot/src/config/mock/fake_sector_pumps.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_pump_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector_pump.dart';
import 'package:irrigazione_iot/src/utils/delay.dart';
import 'package:irrigazione_iot/src/utils/in_memory_store.dart';

class FakeSectorPumpRepository implements SectorPumpRepository {
  FakeSectorPumpRepository({this.addDelay = true});
  final bool addDelay;

  final _sectorPumpsState = InMemoryStore<List<SectorPump>>(kFakeSectorPumps);

  static List<SectorPump?> _getSectorPumps(
      List<SectorPump> sectorPumps, String sectorId) {
    return sectorPumps
        .where((sectorPump) => sectorPump.sectorId == sectorId)
        .toList();
  }

  static SectorPump? _getSectorPump(
      List<SectorPump> sectorPumps, String sectorPumpId) {
    return sectorPumps
        .firstWhereOrNull((sectorPump) => sectorPump.id == sectorPumpId);
  }

  void dispose() => _sectorPumpsState.close();

  @override
  Future<SectorPump?> createSectorPump(SectorPump sectorPump) async {
    await delay(addDelay);
    final currentSectorPumps = [..._sectorPumpsState.value];
    final lastId = currentSectorPumps
        .map((sectorPump) => int.tryParse(sectorPump.id) ?? 0)
        .reduce((maxId, currentId) => maxId > currentId ? maxId : currentId);
    final toAdd = sectorPump.copyWith(id: '${lastId + 1}');
    currentSectorPumps.add(toAdd);
    _sectorPumpsState.value = currentSectorPumps;
    // get and return the added sectorPump
    return _getSectorPump(
      _sectorPumpsState.value,
      toAdd.id,
    );
  }

  @override
  Future<bool> deleteSectorPump(String sectorPumpId) async {
    await delay(addDelay);
    final currentSectorPumps = [..._sectorPumpsState.value];
    final sectorPumpIndex = currentSectorPumps
        .indexWhere((sectorPump) => sectorPump.id == sectorPumpId);
    if (sectorPumpIndex == -1) {
      return false;
    }
    currentSectorPumps.removeAt(sectorPumpIndex);
    _sectorPumpsState.value = currentSectorPumps;
    return _getSectorPump(_sectorPumpsState.value, sectorPumpId) == null;
  }

  @override
  Future<List<SectorPump?>> getSectorPumps(String sectorId) async {
    await delay(addDelay);
    return _getSectorPumps(_sectorPumpsState.value, sectorId);
  }

  @override
  Stream<List<SectorPump?>> watchSectorPumps(String sectorId) {
    return _sectorPumpsState.stream.map((sectorPumps) {
      return _getSectorPumps(sectorPumps, sectorId);
    });
  }
}
