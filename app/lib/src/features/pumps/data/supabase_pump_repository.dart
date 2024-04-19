import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump_database_keys.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump_status_database_keys.dart';
import 'package:irrigazione_iot/src/shared/models/db_cud_bodies.dart';
import 'package:irrigazione_iot/src/utils/supabase_extensions.dart';

class SupabasePumpRepository implements PumpRepository {
  const SupabasePumpRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  Pump? _pumpFromJsonSingle(List<Map<String, dynamic>> data) =>
      data.isEmpty ? null : Pump.fromJson(data.first);

  List<Pump?> _pumpsFromJsonList(List<Map<String, dynamic>> data) {
    return data.map((pump) => Pump.fromJson(pump)).toList();
  }

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
  Stream<List<String?>> watchCompanyUsedPumpNames(String companyId) {
    return watchCompanyPumps(companyId).map(
      (pumps) => pumps.map((pump) => pump?.name.toLowerCase()).toList(),
    );
  }

  @override
  Stream<List<String?>> watchCompanyUsedPumpOffCommands(String companyId) {
    return watchCompanyPumps(companyId).map(
      (pumps) => pumps.map((pump) => pump?.turnOffCommand).toList(),
    );
  }

  @override
  Stream<List<String?>> watchCompanyUsedPumpOnCommands(String companyId) {
    return watchCompanyPumps(companyId).map(
      (pumps) => pumps.map((pump) => pump?.turnOnCommand).toList(),
    );
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
  Stream<List<String?>> watchUsedMqttMessageNames() {
    return _supabaseClient.pumps.stream(primaryKey: [PumpDatabaseKeys.id]).map(
      (pumps) =>
          pumps.map((pump) => Pump.fromJson(pump).mqttMessageName).toList(),
    );
  }
}
