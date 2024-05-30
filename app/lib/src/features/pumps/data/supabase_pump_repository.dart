import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump_database_keys.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump_status_database_keys.dart';
import 'package:irrigazione_iot/src/shared/models/db_cud_bodies.dart';
import 'package:irrigazione_iot/src/utils/extensions/supabase_extensions.dart';

class SupabasePumpRepository implements PumpRepository {
  const SupabasePumpRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  Pump? _pumpFromJsonSingle(List<Map<String, dynamic>> data) =>
      data.isEmpty ? null : Pump.fromJson(data.first);

  List<Pump?> _pumpsFromJsonList(List<Map<String, dynamic>> data) {
    return data.map((pump) => Pump.fromJson(pump)).toList();
  }

  List<Pump>? _fromList(List<Map<String, dynamic>> data) {
    return data.map((pump) => Pump.fromJson(pump)).toList();
  }

  Pump? _toPump(Map<String, dynamic>? json) =>
      json == null ? null : Pump.fromJson(json);

  @override
  Future<Pump?> createPump(Pump pump) async {
    // set created_at and updated_at fields
    final data = pump
        .copyWith(
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        )
        .toJson();
    final res = await _supabaseClient.invokeFunction(
      functionName: 'insert-pump',
      body: InsertBody(data: data).toJson(),
    );
    return res.toObject<Pump>(Pump.fromJson);
  }

  @override
  Future<Pump?> updatePump(Pump pump) async {
    // add the updated_at field
    final data = pump.copyWith(updatedAt: DateTime.now()).toJson();
    final res = await _supabaseClient.invokeFunction(
      functionName: 'update-pump',
      body: UpdateBody(
        id: pump.id,
        data: data,
      ).toJson(),
    );
    return res.toObject<Pump>(Pump.fromJson);
  }

  @override
  Future<bool> deletePump(String pumpId) async {
    final res = await _supabaseClient.invokeFunction(
      functionName: 'delete-pump',
      body: DeleteBody(ids: [pumpId]).toJson(),
    );
    return res.onDelete;
  }

  @override
  Stream<List<Pump?>> watchCompanyPumps(String companyId) {
    final stream =
        _supabaseClient.pumps.stream(primaryKey: [PumpDatabaseKeys.id]).eq(
      PumpDatabaseKeys.companyId,
      companyId,
    );

    return stream.map(_pumpsFromJsonList);
  }

  @override
  Stream<Pump?> watchPump(String pumpId) {
    final stream = _supabaseClient.pumps
        .stream(primaryKey: [PumpDatabaseKeys.id])
        .eq(
          PumpStatusDatabaseKeys.id,
          pumpId,
        )
        .limit(1);

    return stream.map(_pumpFromJsonSingle);
  }
  
  @override
  Future<List<Pump>?> getCompanyPumps(String companyId) async {
    return _supabaseClient.pumps
        .select()
        .eq(PumpDatabaseKeys.companyId, companyId)
        .withConverter(_fromList);
  }

  @override
  Future<List<Pump>?> getAllPumps() async {
    return _supabaseClient.pumps.select().withConverter(_fromList);
  }

  @override
  Future<List<String?>> getCompanyUsedPumpNames(String companyId) async {
    final companyPumps = await getCompanyPumps(companyId);
    if (companyPumps == null || companyPumps.isEmpty) return [];
    return companyPumps.map((pump) => pump.name).toList();
  }

  @override
  Future<List<String?>> getCompanyUsedPumpCommands(String companyId) async {
    final companyPumps = await getCompanyPumps(companyId);

    if (companyPumps == null || companyPumps.isEmpty) return [];

    return companyPumps
        .map((pump) => [pump.turnOnCommand, pump.turnOffCommand])
        .expand((element) => element)
        .toList();
  }


  @override
  Future<Pump?> getPump(String pumpId) async {
    final data = await _supabaseClient.pumps
        .select()
        .eq(PumpDatabaseKeys.id, pumpId)
        .maybeSingle()
        .withConverter(_toPump);
    return data;
  }

  @override
  Future<List<String?>> getUsedMqttMessageNames() async {
    final pumps = await getAllPumps();
    if (pumps == null || pumps.isEmpty) return [];
    return pumps.map((pump) => pump.mqttMessageName).toList();
  }
}
