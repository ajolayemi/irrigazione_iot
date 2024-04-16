import 'package:irrigazione_iot/src/features/sectors/data/sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseSectorRepository implements SectorRepository {
  const SupabaseSectorRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  @override
  Future<Sector?> addSector(Sector sector, String companyId) {
    // TODO: implement addSector
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteSector(String sectorID) {
    // TODO: implement deleteSector
    throw UnimplementedError();
  }

  @override
  Future<Sector?> getSector(String sectorID) {
    // TODO: implement getSector
    throw UnimplementedError();
  }

  @override
  Future<List<Sector?>> getSectors(String companyId) {
    // TODO: implement getSectors
    throw UnimplementedError();
  }

  @override
  Future<Sector?> updateSector(Sector sector, String companyId) {
    // TODO: implement updateSector
    throw UnimplementedError();
  }

  @override
  Stream<List<String?>> watchCompanyUsedSectorNames(String companyId) {
    // TODO: implement watchCompanyUsedSectorNames
    throw UnimplementedError();
  }

  @override
  Stream<List<String?>> watchCompanyUsedSectorOffCommands(String companyId) {
    // TODO: implement watchCompanyUsedSectorOffCommands
    throw UnimplementedError();
  }

  @override
  Stream<List<String?>> watchCompanyUsedSectorOnCommands(String companyId) {
    // TODO: implement watchCompanyUsedSectorOnCommands
    throw UnimplementedError();
  }

  @override
  Stream<Sector?> watchSector(String sectorID) {
    // TODO: implement watchSector
    throw UnimplementedError();
  }

  @override
  Stream<List<Sector?>> watchSectors(String companyId) {
    // TODO: implement watchSectors
    throw UnimplementedError();
  }
}
