import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station_measurements_database_keys.dart';

extension StringExtensions on String {
  /// Returns true if the string is a number and is greater than 0
  /// Mostly used for validating form fields
  bool get isGreaterThanZero =>
      double.tryParse(this) != null && double.parse(this) > 0;

  CompanyUserRole get toCompanyUserRoles => CompanyUserRole.values.firstWhere(
        (role) => role.name == this,
        orElse: () => CompanyUserRole.user,
      );

  String getUmX(String key) {
    switch (key) {
      case WeatherStationMeasurementsDatabaseKeys.airTemperature:
        return '°C';
      case WeatherStationMeasurementsDatabaseKeys.airHumidity:
        return '% RH';
      case WeatherStationMeasurementsDatabaseKeys.lightIntensity:
        return 'Lux';
      case WeatherStationMeasurementsDatabaseKeys.uvIndex:
        return '';
      case WeatherStationMeasurementsDatabaseKeys.windSpeed:
        return 'm/s';
      case WeatherStationMeasurementsDatabaseKeys.windDirection:
        return '°';
      case WeatherStationMeasurementsDatabaseKeys.rainGauge:
        return 'mm';
      case WeatherStationMeasurementsDatabaseKeys.barometricPressure:
        return 'Pa';
      default:
        return '';
    }
  }

  ///
}
