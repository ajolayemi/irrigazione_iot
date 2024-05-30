import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/sectors/data/sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector_database_keys.dart';
import 'package:irrigazione_iot/src/shared/models/db_cud_bodies.dart';
import 'package:irrigazione_iot/src/utils/extensions/supabase_extensions.dart';

class SupabaseSectorRepository implements SectorRepository {
  const SupabaseSectorRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  List<Sector?> _sectorsFromJsonList(List<Map<String, dynamic>> data) {
    return data.map((sector) => Sector.fromJson(sector)).toList();
  }

  List<Sector>? _sectorsFromList(List<Map<String, dynamic>> data) {
    return data.map((sector) => Sector.fromJson(sector)).toList();
  }

  Sector? _sectorFromJsonSingle(List<Map<String, dynamic>> data) {
    return data.isEmpty ? null : Sector.fromJson(data.first);
  }

  @override
  Future<Sector?> createSector(Sector sector) async {
    // set created_at and updated_at fields
    final data = sector
        .copyWith(
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        )
        .toJson();
    final res = await _supabaseClient.invokeFunction(
      functionName: 'insert-sector',
      body: InsertBody(data: data).toJson(),
    );
    return res.toObject<Sector>(Sector.fromJson);
  }

  @override
  Future<Sector?> updateSector(Sector sector) async {
    // add the updated_at field
    final data = sector.copyWith(updatedAt: DateTime.now()).toJson();
    final res = await _supabaseClient.invokeFunction(
      functionName: 'update-sector',
      body: UpdateBody(
        id: sector.id,
        data: data,
      ).toJson(),
    );
    return res.toObject<Sector>(Sector.fromJson);
  }

  @override
  Future<bool> deleteSector(String sectorID) async {
    final res = await _supabaseClient.invokeFunction(
      functionName: 'delete-sector',
      body: DeleteBody(ids: [sectorID]).toJson(),
    );
    return res.onDelete;
  }

  @override
  Stream<List<String?>> watchCompanyUsedSectorNames(String companyId) {
    return watchCompanySectors(companyId).map(
      (sectors) => sectors.map((sector) => sector?.name.toLowerCase()).toList(),
    );
  }

  @override
  Stream<List<String?>> watchCompanySectorUsedCommands(String companyId) {
    return watchCompanySectors(companyId).map(
      (sectors) => sectors
          .map((sector) => [sector?.turnOnCommand, sector?.turnOffCommand])
          .expand((element) => element)
          .toList(),
    );
  }

  @override
  Stream<Sector?> watchSector(String sectorID) {
    final stream = _supabaseClient.sectors.stream(
      primaryKey: [SectorDatabaseKeys.id],
    ).eq(
      SectorDatabaseKeys.id,
      sectorID,
    );

    return stream.map(_sectorFromJsonSingle);
  }

  @override
  Future<Sector?> getSector(String sectorId) async {
    final res = await _supabaseClient.sectors
        .select()
        .eq(SectorDatabaseKeys.id, sectorId);
    return _sectorFromJsonSingle(res);
  }

  @override
  Stream<List<Sector?>> watchCompanySectors(String companyId) {
    final stream = _supabaseClient.sectors.stream(
      primaryKey: [SectorDatabaseKeys.id],
    ).eq(
      SectorDatabaseKeys.companyId,
      companyId,
    );

    return stream.map(_sectorsFromJsonList);
  }

  @override
  Future<List<Sector>?> getAllSectors() async {
    return _supabaseClient.sectors.select().withConverter(_sectorsFromList);
  }

  @override
  Future<List<Sector>?> getCompanySectors(String companyId) {
    return _supabaseClient.sectors
        .select()
        .eq(SectorDatabaseKeys.companyId, companyId)
        .withConverter(_sectorsFromList);
  }

  @override
  Stream<List<String?>> watchSectorUsedMqttMsgNames() {
    return _supabaseClient.sectors
        .stream(primaryKey: [SectorDatabaseKeys.id]).map((sectors) => sectors
            .map((sector) => Sector.fromJson(sector).mqttMsgName.toLowerCase())
            .toList());
  }
}
