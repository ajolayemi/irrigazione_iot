import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/board-centraline/models/board_database_keys.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board_status_database_keys.dart';
import 'package:irrigazione_iot/src/features/collectors/models/collector_database_keys.dart';
import 'package:irrigazione_iot/src/features/collectors/models/collector_pressure_database_keys.dart';
import 'package:irrigazione_iot/src/features/collectors/models/collector_sector_database_keys.dart';
import 'package:irrigazione_iot/src/features/company_users/models/company_database_keys.dart';
import 'package:irrigazione_iot/src/features/company_users/models/company_user_database_keys.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump_database_keys.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump_flow_database_keys.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump_pressure_database_keys.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump_status_database_keys.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector_database_keys.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector_pressure_database_keys.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector_pump_database_keys.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector_status_database_keys.dart';
import 'package:irrigazione_iot/src/features/specie/models/specie_database_keys.dart';
import 'package:irrigazione_iot/src/features/variety/models/variety_database_keys.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station_battery_database_keys.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station_database_keys.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station_measurements_database_keys.dart';

extension SupabaseClientExtensions on SupabaseClient {
  SupabaseQueryBuilder get companies => from(CompanyDatabaseKeys.table);

  PostgrestFilterBuilder<List<Map<String, dynamic>>> get selectedCompanies =>
      companies.select();

  SupabaseQueryBuilder get companyUsers => from(CompanyUserDatabaseKeys.table);

  SupabaseQueryBuilder get pumpFlow => from(PumpFlowDatabaseKeys.table);

  SupabaseQueryBuilder get pumpStatus => from(PumpStatusDatabaseKeys.table);

  SupabaseQueryBuilder get pumps => from(PumpDatabaseKeys.table);

  PostgrestFilterBuilder<List<Map<String, dynamic>>> get selectedPumps =>
      pumps.select();

  SupabaseQueryBuilder get sectors => from(SectorDatabaseKeys.table);

  PostgrestFilterBuilder get selectedSectors => sectors.select();

  SupabaseQueryBuilder get sectorPressure =>
      from(SectorPressureDatabaseKeys.table);

  SupabaseQueryBuilder get sectorStatus => from(SectorStatusDatabaseKeys.table);

  SupabaseQueryBuilder get sectorPump => from(SectorPumpDatabaseKeys.table);

  PostgrestFilterBuilder<List<Map<String, dynamic>>> get selectedSectorPumps =>
      sectorPump.select();

  SupabaseQueryBuilder get varieties => from(VarietyDatabaseKeys.table);

  SupabaseQueryBuilder get species => from(SpecieDatabaseKeys.table);

  SupabaseQueryBuilder get boards => from(BoardDatabaseKeys.table);

  SupabaseStreamFilterBuilder get boardStream => boards.stream(
        primaryKey: [BoardDatabaseKeys.id],
      );

  SupabaseQueryBuilder get boardStatus => from(BoardStatusDatabaseKeys.table);

  SupabaseQueryBuilder get collectors => from(CollectorDatabaseKeys.table);

  SupabaseStreamFilterBuilder get collectorStream =>
      collectors.stream(primaryKey: [CollectorDatabaseKeys.id]);

  SupabaseQueryBuilder get collectorPressures =>
      from(CollectorPressureDatabaseKeys.table);

  SupabaseQueryBuilder get collectorSectors => from(
        CollectorSectorDatabaseKeys.table,
      );

  SupabaseStreamFilterBuilder get collectorSectorsStream =>
      collectorSectors.stream(
        primaryKey: [CollectorSectorDatabaseKeys.id],
      );

  SupabaseQueryBuilder get pumpPressures => from(
        PumpPressureDatabaseKeys.table,
      );

  SupabaseStreamFilterBuilder get pumpPressuresStream => pumpPressures.stream(
        primaryKey: [PumpPressureDatabaseKeys.id],
      );

  SupabaseQueryBuilder get weatherStations =>
      from(WeatherStationDatabaseKeys.table);

  SupabaseStreamFilterBuilder get weatherStationStream =>
      weatherStations.stream(primaryKey: [WeatherStationDatabaseKeys.id]);

  SupabaseQueryBuilder get weatherStationMeasurements =>
      from(WeatherStationMeasurementsDatabaseKeys.table);

  SupabaseQueryBuilder get weatherStationBatteryData =>
      from(WeatherStationBatteryDatabaseKeys.table);

  /// Getter for the current access token
  String? get accessToken => auth.currentSession?.accessToken;

  /// Invokes a function with the provided [functionName] and [body]
  Future<FunctionResponse> invokeFunction({
    required String functionName,
    required Map<String, dynamic> body,
  }) =>
      functions.invoke(
        functionName,
        body: body,
        headers: accessToken != null
            ? {'Authorization': 'Bearer $accessToken'}
            : null,
      );
}

extension FunctionResponseExtensions on FunctionResponse {
  /// Converts the response data to a [T] object
  /// This is useful when the response data is a single object
  T? toObject<T>(T Function(Map<String, dynamic>) fromJson) {
    final data = this.data as Map<String, dynamic>?;
    final toTransform = data?['data'];
    if (toTransform != null) {
      return fromJson(toTransform);
    }

    return null;
  }

  /// Returns true if the status code is 200 or 204
  bool get onDelete => status == 200 || status == 204;
}
