import 'package:collection/collection.dart';
import 'package:irrigazione_iot/src/config/mock/fake_sectors.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector.dart';
import 'package:irrigazione_iot/src/utils/delay.dart';
import 'package:irrigazione_iot/src/utils/in_memory_store.dart';

class FakeSectorRepository extends SectorRepository {
  FakeSectorRepository({this.addDelay = true});
  final bool addDelay;

  final _sectorsState = InMemoryStore<List<Sector>>(kFakeSectors);

  @override
  Future<Sector?> addSector(Sector sector, String companyId) async {
    // data validation logic is handled directly in the form
    await delay(addDelay);
    final lastUsedSectorId = _sectorsState.value
        .map((sector) => int.tryParse(sector.id) ?? 0)
        .reduce((maxId, currentId) => maxId > currentId ? maxId : currentId);
    final finalSector = sector.copyWith(
      id: '${lastUsedSectorId + 1}',
      companyId: companyId,
    );
    final currentSectors = [..._sectorsState.value];
    currentSectors.add(finalSector);
    _sectorsState.value = currentSectors;
    return Future.value(finalSector);
  }

  @override
  Future<Sector?> updateSector(
    Sector sector,
    String companyId,
  ) async {
    // data validation logic is handled directly in the form
    await delay(addDelay);
    final currentSectors = [..._sectorsState.value];
    final index = currentSectors
        .indexWhere((s) => s.id == sector.id && s.companyId == companyId);
    if (index < 0) return Future.value(null);
    // return early if the new provided sector is the same as the old one
    if (currentSectors[index] == sector) return Future.value(sector);
    currentSectors[index] = sector;
    _sectorsState.value = currentSectors;
    return getSector(sector.id);
  }

  @override
  Future<bool> deleteSector(String sectorID) async {
    await delay(addDelay);
    final currentSectors = [..._sectorsState.value];
    final index = currentSectors.indexWhere((sector) => sector.id == sectorID);
    if (index < 0) return Future.value(false);
    currentSectors.removeAt(index);
    _sectorsState.value = currentSectors;
    return await getSector(sectorID) == null;
  }

  @override
  Future<List<Sector?>> getSectors(String companyId) {
    return Future.value(_getSectors(_sectorsState.value, companyId));
  }

  @override
  Stream<List<Sector?>> watchSectors(String companyId) {
    return _sectorsState.stream
        .map((sectors) => _getSectors(sectors, companyId));
  }

  @override
  Stream<Sector?> watchSector(String sectorID) {
    return _sectorsState.stream.map((sectors) => _getSector(sectors, sectorID));
  }

  @override
  Future<Sector?> getSector(String sectorID) async {
    await delay(addDelay);
    return Future.value(_getSector(_sectorsState.value, sectorID));
  }

  @override
  Stream<List<String?>> watchCompanyUsedSectorNames(String companyId) {
    return _sectorsState.stream.map(
      (sectors) => _getSectors(sectors, companyId)
          .map((sector) => sector?.name.toLowerCase())
          .toList(),
    );
  }

  @override
  Stream<List<String?>> watchCompanyUsedSectorOffCommands(String companyId) {
    return _sectorsState.stream.map(
      (sectors) => _getSectors(sectors, companyId)
          .map((sector) => sector?.turnOffCommand)
          .toList(),
    );
  }

  @override
  Stream<List<String?>> watchCompanyUsedSectorOnCommands(String companyId) {
    return _sectorsState.stream.map(
      (sectors) => _getSectors(sectors, companyId)
          .map((sector) => sector?.turnOnCommand)
          .toList(),
    );
  }

  static List<Sector?> _getSectors(List<Sector?> sectors, String companyId) {
    return sectors.where((sector) => sector?.companyId == companyId).toList();
  }

  static Sector? _getSector(List<Sector?> sectors, String sectorID) {
    return sectors.firstWhereOrNull((sector) => sector?.id == sectorID);
  }

  void dispose() => _sectorsState.close();
}