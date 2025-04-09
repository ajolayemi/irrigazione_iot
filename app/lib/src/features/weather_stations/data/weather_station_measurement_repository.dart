import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/constants/app_constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/weather_stations/data/supabase_weather_station_measurement_repository.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station_measurement.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'weather_station_measurement_repository.g.dart';

abstract class WeatherStationMeasurementRepository {
  Future<WeatherStationMeasurement?> getStationMeasurement(
    String weatherStationId,
  );
}

@Riverpod(keepAlive: true)
WeatherStationMeasurementRepository weatherStationMeasurementRepository(
    Ref ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabaseWeatherStationMeasurementRepository(supabaseClient);
}

@Riverpod(keepAlive: true)
FutureOr<WeatherStationMeasurement?> weatherStationMeasurement(
  Ref ref, {
  required String weatherStationId,
}) {
  final timer = Timer.periodic(
    AppConstants.weatherStationMeasurementUpdateInterval,
    (_) {
      ref.invalidateSelf();
    },
  );

  ref.onDispose(() {
    timer.cancel();
  });
  final repo = ref.watch(weatherStationMeasurementRepositoryProvider);
  return repo.getStationMeasurement(weatherStationId);
}
