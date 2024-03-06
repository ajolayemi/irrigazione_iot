import 'package:collection/collection.dart';
import 'package:irrigazione_iot/src/config/mock/fake_sectors.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/domain/sector.dart';
import 'package:irrigazione_iot/src/features/user_companies/domain/company.dart';
import 'package:irrigazione_iot/src/utils/delay.dart';
import 'package:irrigazione_iot/src/utils/in_memory_store.dart';

class FakeSectorsRepository extends SectorsRepository {
  FakeSectorsRepository({this.addDelay = true});
  final bool addDelay;

  final _sectorsState = InMemoryStore<List<Sector>>(kFakeSectors);

  @override
  Future<void> addSector(Sector sector, CompanyID companyId) {
    // TODO: implement addSector
    throw UnimplementedError();
  }

  @override
  Future<void> deleteSector(SectorID sectorID) {
    // TODO: implement deleteSector
    throw UnimplementedError();
  }

  @override
  Future<List<Sector?>> fetchSectors(CompanyID companyId) {
    // TODO: implement fetchSectors
    throw UnimplementedError();
  }

  @override
  Future<void> updateSector(SectorID sectorID) {
    // TODO: implement updateSector
    throw UnimplementedError();
  }

  @override
  Stream<List<Sector?>> watchSectors(CompanyID companyId) {
    return _sectorsState.stream
        .map((sectors) => _getSectors(sectors, companyId));
  }

  static List<Sector?> _getSectors(List<Sector?> sectors, CompanyID companyId) {
    return sectors.where((sector) => sector?.companyId == companyId).toList();
  }

  static Sector? _getSector(List<Sector?> sectors, SectorID sectorID) {
    return sectors.firstWhereOrNull((sector) => sector?.id == sectorID);
  }

  @override
  Stream<Sector?> watchSector(SectorID sectorID) {
    return _sectorsState.stream.map((sectors) => _getSector(sectors, sectorID));
  }

  @override
  Future<Sector?> fetchSector(SectorID sectorID) async {
    await delay(addDelay);
    return Future.value(_getSector(_sectorsState.value, sectorID));
  }
}
