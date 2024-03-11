import 'package:collection/collection.dart';
import 'package:irrigazione_iot/src/config/mock/fake_sectors.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector.dart';
import 'package:irrigazione_iot/src/features/user_companies/model/company.dart';
import 'package:irrigazione_iot/src/utils/delay.dart';
import 'package:irrigazione_iot/src/utils/in_memory_store.dart';

class FakeSectorsRepository extends SectorsRepository {
  FakeSectorsRepository({this.addDelay = true});
  final bool addDelay;

  final _sectorsState = InMemoryStore<List<Sector>>(kFakeSectors);

  @override
  Future<Sector?> addSector(Sector sector, CompanyID companyId) async {
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
    return Future.value(sector);
  }

  @override
  Future<Sector?> updateSector(
    Sector sector,
    CompanyID companyId,
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
  Future<bool> deleteSector(SectorID sectorID) async {
    await delay(addDelay);
    final currentSectors = [..._sectorsState.value];
    final index = currentSectors.indexWhere((sector) => sector.id == sectorID);
    if (index < 0) return Future.value(false);
    currentSectors.removeAt(index);
    _sectorsState.value = currentSectors;
    return await getSector(sectorID) == null;
  }

  @override
  Future<List<Sector?>> getSectors(CompanyID companyId) {
    return Future.value(_getSectors(_sectorsState.value, companyId));
  }

  @override
  Stream<List<Sector?>> watchSectors(CompanyID companyId) {
    return _sectorsState.stream
        .map((sectors) => _getSectors(sectors, companyId));
  }

  @override
  Stream<Sector?> watchSector(SectorID sectorID) {
    return _sectorsState.stream.map((sectors) => _getSector(sectors, sectorID));
  }

  @override
  Future<Sector?> getSector(SectorID sectorID) async {
    await delay(addDelay);
    return Future.value(_getSector(_sectorsState.value, sectorID));
  }

  @override
  Stream<List<String?>> watchCompanyUsedSectorNames(CompanyID companyId) {
    return _sectorsState.stream.map(
      (sectors) => _getSectors(sectors, companyId)
          .map((sector) => sector?.name.toLowerCase())
          .toList(),
    );
  }

  @override
  Stream<List<String?>> watchCompanyUsedSectorOffCommands(CompanyID companyId) {
    return _sectorsState.stream.map(
      (sectors) => _getSectors(sectors, companyId)
          .map((sector) => sector?.turnOffCommand)
          .toList(),
    );
  }

  @override
  Stream<List<String?>> watchCompanyUsedSectorOnCommands(CompanyID companyId) {
    return _sectorsState.stream.map(
      (sectors) => _getSectors(sectors, companyId)
          .map((sector) => sector?.turnOnCommand)
          .toList(),
    );
  }

  static List<Sector?> _getSectors(List<Sector?> sectors, CompanyID companyId) {
    return sectors.where((sector) => sector?.companyId == companyId).toList();
  }

  static Sector? _getSector(List<Sector?> sectors, SectorID sectorID) {
    return sectors.firstWhereOrNull((sector) => sector?.id == sectorID);
  }

  void dispose() => _sectorsState.close();
}
