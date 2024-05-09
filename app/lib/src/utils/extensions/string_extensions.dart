import 'package:irrigazione_iot/src/features/sensors/models/sensor_measurements_database_keys.dart';

extension StringExtensions on String {
  /// Returns true if the string is a number and is greater than 0
  /// Mostly used for validating form fields
  bool get isGreaterThanZero =>
      double.tryParse(this) != null && double.parse(this) > 0;


  String getUmX(String key) {
    switch (key) {
      case SensorMeasurementsDatabaseKeys.airTemperature:
        return '°C';
      case SensorMeasurementsDatabaseKeys.airHumidity:
        return '% RH';
      case SensorMeasurementsDatabaseKeys.lightIntensity:
        return 'Lux';
      case SensorMeasurementsDatabaseKeys.uvIndex:
        return '';
      case SensorMeasurementsDatabaseKeys.windSpeed:
        return 'm/s';
      case SensorMeasurementsDatabaseKeys.windDirection:
        return '°';
      case SensorMeasurementsDatabaseKeys.rainGauge:
        return 'mm';
      case SensorMeasurementsDatabaseKeys.barometricPressure:
        return 'Pa';
      default:
        return '';
    }
  }

  ///
}