import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/weather_stations/data/sensor_repository.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/sensor.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/sensor_database_keys.dart';
import 'package:irrigazione_iot/src/shared/models/db_cud_bodies.dart';
import 'package:irrigazione_iot/src/utils/extensions/supabase_extensions.dart';

class SupabaseSensorRepository implements SensorRepository {
  const SupabaseSensorRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  List<WeatherStation>? _sensorsFromJsonList(List<Map<String, dynamic>> data) {
    return data.map((sensor) => WeatherStation.fromJson(sensor)).toList();
  }

  WeatherStation? _sensorFromJsonSingle(List<Map<String, dynamic>> data) {
    return data.isEmpty ? null : WeatherStation.fromJson(data.first);
  }

  @override
  Future<WeatherStation?> createSensor(WeatherStation sensor) async {
    final data = sensor
        .copyWith(
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        )
        .toJson();
    final res = await _supabaseClient.invokeFunction(
        functionName: 'insert-sensor', body: InsertBody(data: data).toJson());
    return res.toObject<WeatherStation>(WeatherStation.fromJson);
  }

  @override
  Future<WeatherStation?> updateSensor(WeatherStation sensor) async {
    final data = sensor.copyWith(updatedAt: DateTime.now()).toJson();
    final res = await _supabaseClient.invokeFunction(
      functionName: 'update-sensor',
      body: UpdateBody(id: sensor.id, data: data).toJson(),
    );
    return res.toObject<WeatherStation>(WeatherStation.fromJson);
  }

  @override
  Future<bool> deleteSensor(String sensorId) async {
    final res = await _supabaseClient.invokeFunction(
      functionName: 'delete-sensor',
      body: DeleteBody(ids: [sensorId]).toJson(),
    );
    return res.onDelete;
  }

  @override
  Stream<WeatherStation?> watchSensor(String id) {
    final stream = _supabaseClient.sensorStream.eq(SensorDatabaseKeys.id, id);

    return stream.map(_sensorFromJsonSingle);
  }

  @override
  Stream<List<WeatherStation>?> watchSensors(String companyId) {
    final stream = _supabaseClient.sensorStream
        .eq(SensorDatabaseKeys.companyId, companyId);

    return stream.map(_sensorsFromJsonList);
  }

  @override
  Stream<List<String?>> watchUsedSensorNames() {
    return _supabaseClient.sensorStream.map((data) {
      return data
          .map((sensor) =>
              sensor[SensorDatabaseKeys.name].toString().toLowerCase())
          .toList();
    });
  }

  @override
  Stream<List<String?>> watchUsedSensorEUIs() {
    return _supabaseClient.sensorStream.map((data) {
      return data
          .map((sensor) =>
              sensor[SensorDatabaseKeys.eui].toString().toLowerCase())
          .toList();
    });
  }

  @override
  Stream<int> watchSensorsCount(String sectorId) {
    final stream =
        _supabaseClient.sensorStream.eq(SensorDatabaseKeys.sectorId, sectorId);

    return stream.map((data) => data.length);
  }
}
