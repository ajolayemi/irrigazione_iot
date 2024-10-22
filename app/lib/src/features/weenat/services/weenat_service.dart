import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/config/enums/weenat_sensor_data_types.dart';
import 'package:irrigazione_iot/src/data/datasource/dao/weenat_dao.dart';
import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/weenat/data/weenat_repository.dart';
import 'package:irrigazione_iot/src/features/weenat/models/weenat_auth_payload.dart';
import 'package:irrigazione_iot/src/features/weenat/models/weenat_plot.dart';
import 'package:irrigazione_iot/src/features/weenat/models/weenat_plot_sensor_data.dart';
import 'package:irrigazione_iot/src/features/weenat/providers/weenat_providers.dart';
import 'package:irrigazione_iot/src/shared/services/shared_preferences_service.dart';

part 'weenat_service.g.dart';

class WeenatService {
  WeenatService(this._ref);
  final Ref _ref;

  Future<bool> authWeenatService({
    required WeenatAuthPayload payload,
  }) async {
    try {
      // Access repository
      final repo = _ref.read(weenatRepositoryProvider);

      final prefService = _ref.read(sharedPrefsServiceProvider);
      final uid = _ref.read(userUidProvider);
      // Clear current saved preferences
      prefService.clearWeenatTokenPrefs(uid: uid);

      // Make call to authenticate
      final token = await repo.authWeenat(payload: payload);
      if (token == null || token.isEmpty) {
        return false;
      }

      // Save token to shared preferences
      await prefService.setUserWeenatToken(
        token: token,
        uid: uid,
      );

      // After successful authentication, make call to get plots
      final plots = await repo.getPlots(token: token) ?? [];
      final plotsEntities = plots.toEntities();
      // Insert plots into local database
      await _ref
          .read(weenatDaoProvider)
          .insertWeenatPlots(plots: plotsEntities);

      return true;
    } catch (error) {
      rethrow;
    } finally {
      _ref.invalidate(weenatTokenProvider);
    }
  }

  Future<List<WeenatPlotSensorData>?> getPlotSensorData({
    required DateTime from,
    required DateTime to,
    required int plotId,
    required WeenatSensorDataType type,
    required int depth,
    bool forceRefresh = false,
    int? orgId,
  }) async {
    try {
      List<WeenatPlotSensorData> sensorData = [];

      // retrieve last time sensor data was updated from shared preferences
      final prefService = _ref.read(sharedPrefsServiceProvider);
      final lastUpdated = await prefService.getPlotSensorDataTimestamp(
        plotId: plotId,
      );
      final lastUpdatedToDateTime = DateTime.tryParse(lastUpdated.toString());

      // Check if the last time sensor data was updated is within the valid time frame
      if (lastUpdatedToDateTime != null && !forceRefresh) {
        if (lastUpdatedToDateTime.hour == from.hour) {
          /// The same time interval is used when asking for sensor data
          /// from the database to make sure that just a single value is returned
          final fromDb = await _ref.read(weenatDaoProvider).getPlotSensorData(
                from: from,
                to: from,
                plotId: plotId,
                depth: depth,
                type: type,
              );

          final toModels = fromDb?.toModels();
          return toModels;
        }
      }

      // For the given [to] value, add an hour
      final finalEndDate = to.add(const Duration(hours: 1));

      final repo = _ref.read(weenatRepositoryProvider);
      final user = _ref.read(authRepositoryProvider).currentUser;
      final token = await prefService.getUserWeenatToken(uid: user?.uid);
      final data = await repo.getMeasures(
        plotId: plotId,
        unixStart: from.millisecondsSinceEpoch,
        unixEnd: finalEndDate.millisecondsSinceEpoch,
        token: token ?? '',
      );

      if (data == null || data.isEmpty) return [];

      // Loop over the returned data
      for (final entry in data.entries) {
        final currentUnixTimestamp = entry.key;

        final timestamp = DateTime.fromMillisecondsSinceEpoch(
          int.parse(currentUnixTimestamp) * 1000,
        );

        final values = Map<String, dynamic>.from(entry.value);

        final copiedValue = Map<String, dynamic>.from(values);

        final keys = values.keys.toList();

        // Access the keys in the values that match the pattern for extracting
        // water potential and temperature values
        final tempRegex = RegExp(r'T_[0-9]+');
        final waterPotentialRegex = RegExp(r'WHYD_[0-9]+');

        // Run the regex on the keys
        final tempMatches = keys
            .where(
              (key) => tempRegex.hasMatch(key),
            )
            .toList();
        final waterPotentialMatches = keys
            .where(
              (key) => waterPotentialRegex.hasMatch(key),
            )
            .toList();

        final combinedKeys = [...tempMatches, ...waterPotentialMatches];

        // Starting from temperature matches, remove the keys found from
        // copiedValue
        for (final key in combinedKeys) {
          copiedValue.remove(key);
        }

        /// Clean the sensor data
        sensorData.addAll(cleanSensorData(
          originalData: values,
          copiedData: copiedValue,
          keys: tempMatches,
          timestamp: timestamp,
          plotId: plotId,
          dataType: WeenatSensorDataType.temperature,
        ));

        sensorData.addAll(cleanSensorData(
          originalData: values,
          copiedData: copiedValue,
          keys: waterPotentialMatches,
          timestamp: timestamp,
          plotId: plotId,
          dataType: WeenatSensorDataType.waterPotential,
        ));
      }

      final toEntity = sensorData.toEntities();

      // Insert sensor data into local database
      await _ref.read(weenatDaoProvider).insertSensorData(data: toEntity);

      // Save the last time sensor data was updated
      await prefService.setPlotSensorDataTimestamp(
        plotId: plotId,
        timestamp: DateTime.now(),
      );

      // Return the matching sensor data
      return sensorData.where(
        (data) {
          // Return data who has the provided data type, depth, plotId and timestamp
          final isType = data.dataType == type;
          final isDepth = data.sensorDataDepth == depth;
          final isPlotId = data.plotId == plotId;
          final isTimestamp = data.timeStamp == data.timeStamp;
          return isType && isDepth && isPlotId && isTimestamp;
        },
      ).toList();
    } catch (_) {
      rethrow;
    }
  }

  /// Helps in cleaning sensor data retrieved from the server
  List<WeenatPlotSensorData> cleanSensorData({
    required Map<String, dynamic> originalData,
    required Map<String, dynamic> copiedData,
    required List<String> keys,
    required DateTime timestamp,
    required int plotId,
    required WeenatSensorDataType dataType,
  }) {
    List<WeenatPlotSensorData> sensorData = [];
    final copiedValue = Map<String, dynamic>.from(copiedData);

    /// Loop over the temperature matches and create a new list of
    /// [WeenatPlotSensorData] objects
    for (final key in keys) {
      final depth = int.parse(key.split('_')[1]);

      // A custom id used for tracking data in local database is sum of
      // the plotId, the timestamp milliseconds since epoch, the depth and an id identifying the data type

      final customId =
          plotId + timestamp.millisecondsSinceEpoch + depth + dataType.id;
      final dataTypeName = dataType.name;
      final temperatureJson = {
        WeenatPlotSensorData.idKey: customId,
        WeenatPlotSensorData.dataTypeKey: dataTypeName,
        WeenatPlotSensorData.sensorDataKey: originalData[key],
        WeenatPlotSensorData.sensorDataDepthKey: depth,
        WeenatPlotSensorData.timeStampKey: timestamp.toIso8601String(),
        WeenatPlotSensorData.plotIdKey: plotId,
      };

      copiedValue.addAll(temperatureJson);

      sensorData.add(WeenatPlotSensorData.fromJson(copiedValue));
    }

    return sensorData;
  }
}

@Riverpod(keepAlive: true)
WeenatService weenatService(WeenatServiceRef ref) {
  return WeenatService(ref);
}
