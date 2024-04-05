import 'package:collection/collection.dart';
import '../../../config/mock/fake_sector_pumps.dart';
import 'sector_pump_repository.dart';
import '../model/sector.dart';
import '../model/sector_pump.dart';
import '../../../utils/delay.dart';
import '../../../utils/in_memory_store.dart';

class FakeSectorPumpRepository implements SectorPumpRepository {
  FakeSectorPumpRepository({this.addDelay = true});
  final bool addDelay;

  final _sectorPumpsState = InMemoryStore<List<SectorPump>>(kFakeSectorPumps);

  static List<SectorPump?> _getSectorPumps(
      List<SectorPump> sectorPumps, SectorID sectorId) {
    return sectorPumps
        .where((sectorPump) => sectorPump.sectorId == sectorId)
        .toList();
  }

  static SectorPump? _getSectorPump(
      List<SectorPump> sectorPumps, String sectorId, String pumpId) {
    return sectorPumps.firstWhereOrNull((sectorPump) =>
        sectorPump.sectorId == sectorId && sectorPump.pumpId == pumpId);
  }

  void dispose() => _sectorPumpsState.close();

  @override
  Future<SectorPump?> addSectorPump(SectorPump sectorPump) async {
    await delay(addDelay);
    final currentSectorPumps = [..._sectorPumpsState.value];
    currentSectorPumps.add(sectorPump);
    _sectorPumpsState.value = currentSectorPumps;
    // get and return the added sectorPump
    return _getSectorPump(
      _sectorPumpsState.value,
      sectorPump.sectorId,
      sectorPump.pumpId,
    );
  }


  @override
  Future<bool> deleteSectorPump(String sectorId, String pumpId) async {
    await delay(addDelay);
    final currentSectorPumps = [..._sectorPumpsState.value];
    final sectorPumpIndex = currentSectorPumps.indexWhere((sectorPump) =>
        sectorPump.sectorId == sectorId && sectorPump.pumpId == pumpId);
    if (sectorPumpIndex == -1) {
      return false;
    }
    currentSectorPumps.removeAt(sectorPumpIndex);
    _sectorPumpsState.value = currentSectorPumps;
    return _getSectorPump(_sectorPumpsState.value, sectorId, pumpId) == null;
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