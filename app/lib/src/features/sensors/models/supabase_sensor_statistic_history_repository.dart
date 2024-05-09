import 'package:irrigazione_iot/src/features/sensors/models/sensor_measurements_database_keys.dart';
import 'package:irrigazione_iot/src/features/sensors/models/sensor_statistic_history.dart';
import 'package:irrigazione_iot/src/features/sensors/models/sensor_statistic_history_repository.dart';
import 'package:irrigazione_iot/src/utils/extensions/supabase_extensions.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseSensorStatisticHistoryRepository
    implements SensorStatisticHistoryRepository {
  const SupabaseSensorStatisticHistoryRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  String get _createdAt => SensorMeasurementsDatabaseKeys.createdAt;
  String get _sensorId => SensorMeasurementsDatabaseKeys.sensorId;

  List<SensorStatisticHistory> _convertToSensorStatisticHistory(
    List<Map<String, dynamic>> data,
    String colName,
  ) {
    return data
        .map((e) => SensorStatisticHistory(
              value: e[colName] as num,
              createdAt: DateTime.parse(e[_createdAt] as String),
            ))
        .toList();
  }

  @override
  Future<List<SensorStatisticHistory>?> sensorStatisticsStream(
    String sensorId,
    String colName, {
    int limit = 30,
  }) {
    return _supabaseClient.sensorMeasurements
        .select('$colName, $_createdAt')
        .eq(_sensorId, sensorId)
        .order(_createdAt, ascending: false)
        .limit(limit)
        .withConverter(
            (data) => _convertToSensorStatisticHistory(data, colName));
  }
}
