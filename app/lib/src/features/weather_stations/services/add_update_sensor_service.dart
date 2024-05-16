import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/features/weather_stations/data/sensor_repository.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_update_sensor_service.g.dart';

class AddUpdateSensorService {
  const AddUpdateSensorService(this._ref);
  final Ref _ref;

  Future<void> createSensor(WeatherStation sensor) async {
    final user = _ref.read(authRepositoryProvider).currentUser;

    if (user == null) {
      debugPrint('No user found, cannot create sensor');
      return;
    }

    final selectedCompanyRepo = _ref.read(selectedCompanyRepositoryProvider);
    final companyId = selectedCompanyRepo.loadSelectedCompanyId(user.uid);

    if (companyId == null) {
      debugPrint('No company selected, cannot create sensor');
    }

    final sensorRepo = _ref.read(sensorRepositoryProvider);

    final createdSensor = await sensorRepo.createSensor(
      sensor.copyWith(
        companyId: companyId,
      ),
    );

    if (createdSensor == null) {
      debugPrint('Sensor creation failed');
    }

    debugPrint('Created sensor: ${createdSensor?.toJson()}');
  }

  Future<void> updateSensor(WeatherStation sensor) async {
    final user = _ref.read(authRepositoryProvider).currentUser;

    if (user == null) {
      debugPrint('No user found, cannot update sensor');
      return;
    }

    final selectedCompanyRepo = _ref.read(selectedCompanyRepositoryProvider);
    final companyId = selectedCompanyRepo.loadSelectedCompanyId(user.uid);

    if (companyId == null) {
      debugPrint('No company selected, cannot update sensor');
    }

    final sensorRepo = _ref.read(sensorRepositoryProvider);

    final updatedSensor = await sensorRepo.updateSensor(
      sensor.copyWith(
        companyId: companyId,
      ),
    );

    if (updatedSensor == null) {
      debugPrint('Sensor update failed');
    }

    debugPrint('Updated sensor: ${updatedSensor?.toJson()}');
  }
}

@Riverpod(keepAlive: true)
AddUpdateSensorService addUpdateSensorService(AddUpdateSensorServiceRef ref) {
  return AddUpdateSensorService(ref);
}
