import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/features/weather_stations/data/weather_station_repository.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station.dart';

part 'add_update_weather_station_service.g.dart';

class AddUpdateWeatherStationService {
  const AddUpdateWeatherStationService(this._ref);
  final Ref _ref;

  Future<void> createWeatherStation(WeatherStation weatherStation) async {
    final user = _ref.read(authRepositoryProvider).currentUser;

    if (user == null) {
      debugPrint('No user found, cannot create weather station');
      return;
    }

    final selectedCompanyRepo = _ref.read(selectedCompanyRepositoryProvider);
    final companyId = selectedCompanyRepo.loadSelectedCompanyId(user.uid);

    if (companyId == null) {
      debugPrint('No company selected, cannot create weather station');
    }

    final weatherStationRepo = _ref.read(weatherStationRepositoryProvider);

    final createdWeatherStation = await weatherStationRepo.createWeatherStation(
      weatherStation.copyWith(companyId: companyId),
    );

    if (createdWeatherStation == null) {
      debugPrint('Weather station creation failed');
    }

    debugPrint('Created weather station: ${createdWeatherStation?.toJson()}');
  }

  Future<void> updateWeatherStation(WeatherStation weatherStation) async {
    final user = _ref.read(authRepositoryProvider).currentUser;

    if (user == null) {
      debugPrint('No user found, cannot update weather station');
      return;
    }

    final selectedCompanyRepo = _ref.read(selectedCompanyRepositoryProvider);
    final companyId = selectedCompanyRepo.loadSelectedCompanyId(user.uid);

    if (companyId == null) {
      debugPrint('No company selected, cannot update weather station');
    }

    final weatherStationRepo = _ref.read(weatherStationRepositoryProvider);

    final updatedWeatherStation = await weatherStationRepo.updateWeatherStation(
      weatherStation.copyWith(companyId: companyId),
    );

    if (updatedWeatherStation == null) {
      debugPrint('Weather station update failed');
    }

    debugPrint('Updated weather station: ${updatedWeatherStation?.toJson()}');
  }
}

@Riverpod(keepAlive: true)
AddUpdateWeatherStationService addUpdateWeatherStationService(
    AddUpdateWeatherStationServiceRef ref) {
  return AddUpdateWeatherStationService(ref);
}
