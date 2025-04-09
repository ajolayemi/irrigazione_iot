import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/board-centraline/data/board_repository.dart';
import 'package:irrigazione_iot/src/features/board-centraline/data/board_status_repository.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_pump_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector.dart';
import 'package:irrigazione_iot/src/features/weather_stations/data/weather_station_battery_repository.dart';
import 'package:irrigazione_iot/src/features/weather_stations/data/weather_station_measurement_repository.dart';
import 'package:irrigazione_iot/src/features/weather_stations/data/weather_station_repository.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station.dart';

class ProviderUtils {
  const ProviderUtils._();

  /// Helper function to invalidate states of various providers
  /// Connected to the board entity
  static void invalidateBoardStates({required Ref ref, Board? board}) {
    // Invalidate general list of boards provider
    ref.invalidate(boardsListProvider);

    if (board != null) {
      // Invalidate the specific board provider
      ref.invalidate(boardProvider(boardId: board.id));

      // Invalidate the collector board provider
      ref.invalidate(collectorBoardProvider(collectorId: board.collectorId));
    }

    // Invalidate the provider that holds list of used board names
    ref.invalidate(usedBoardNamesProvider);
  }

  /// Invalidates the states of different providers connected to
  /// the weather station entity
  static void invalidateWeatherStationStates({required Ref ref, WeatherStation? weatherStation}) {
    // Invalidate general list of weather stations provider
    ref.invalidate(weatherStationsProvider);

    if (weatherStation != null) {
      // Invalidate the specific weather station provider
      ref.invalidate(weatherStationProvider(weatherStation.id));

      // Invalidate count of weather stations connected to a specific sector
      ref.invalidate(weatherStationsCountProvider(weatherStation.sectorId));
    }

    // Invalidate the provider that holds onto the names of used stations
    // name
    ref.invalidate(usedWeatherStationsNamesProvider);

    // Invalidate the provider that holds onto the EUIs of used weather stations
    ref.invalidate(usedWeatherStationEUIsProvider);
  }

  /// Invalidates the states of different providers connected to
  /// the pump entity
  static void invalidatePumpStates({required Ref ref, Pump? pump}) {
    // invalidate the available pumps so that the newly created pump is included
    ref.invalidate(availablePumpsFutureProvider);

    // invalidate the general list of pumps, this forces its state to refresh
    ref.invalidate(companyPumpsProvider);
  }

  /// Invalidates the states of different providers connected to
  /// the sector entity
  static void invalidateSectorStates({required Ref ref, Sector? sector}) {
    ref.invalidate(sectorsProvider);
    ref.invalidate(allSectorsFutureProvider);
    ref.invalidate(usedSectorNamesFutureProvider);
    ref.invalidate(usedSectorCommandsFutureProvider);
    ref.invalidate(sectorUsedMqttMessageNamesFutureProvider);
    if (sector != null) {
      ref.invalidate(sectorProvider(sector.id));
      ref.invalidate(sectorPumpFutureProvider(sector.id));
    }
  }

  /// Helps in refreshing the states of some providers when user pulls to refresh
  /// on the board lists screen
  static Future<void> refreshBoardListStates(WidgetRef ref) async {
    ref.refresh(boardsListProvider.future).ignore();
    final boards = ref.read(boardsListProvider).valueOrNull;
    if (boards != null) {
      for (final board in boards) {
        ref.refresh(boardStatusProvider(boardId: board.id).future).ignore();
        ref.refresh(collectorBoardProvider(collectorId: board.collectorId).future).ignore();
      }
    }
  }

  /// Helps in refreshing the states of some providers when user pulls to refresh
  /// on the weather stations lists screen
  static Future<void> refreshWeatherStationsListStates(WidgetRef ref) async {
    // Refresh the general list of weather stations
    ref.refresh(weatherStationsProvider.future).ignore();

    // Access the list of weather stations
    final weatherStations = ref.read(weatherStationsProvider).valueOrNull;
    if (weatherStations != null) {
      for (final weatherStation in weatherStations) {
        ref.refresh(weatherStationsCountProvider(weatherStation.id).future).ignore();
        ref.refresh(weatherStationBatteryProvider(weatherStationId: weatherStation.id).future).ignore();
        ref.refresh(weatherStationMeasurementProvider(weatherStationId: weatherStation.id).future).ignore();
      }
    }
  }

  /// Helps in refreshing the states of some providers when user pulls to refresh
  /// on the pumps lists screen
  static Future<void> refreshPumpsListStates(WidgetRef ref) async {
    // Refresh the general list of pumps
    ref.refresh(companyPumpsProvider.future).ignore();

    // TODO: refresh other pump related states
  }

  /// Helps in refreshing the states of some providers when user pulls to refresh
  /// on the sectors lists screen
  static Future<void> refreshSectorsStates(WidgetRef ref) async {
    // Refresh the general list of sectors
    ref.refresh(sectorsProvider.future).ignore();

    ref.invalidate(allSectorsFutureProvider);
    ref.invalidate(usedSectorNamesFutureProvider);
    ref.invalidate(usedSectorCommandsFutureProvider);
    ref.invalidate(sectorUsedMqttMessageNamesFutureProvider);

    // Access list of available sectors
    final sectors = ref.read(sectorsProvider).valueOrNull;
    if (sectors != null) {
      for (final sector in sectors) {
        ref.refresh(sectorProvider(sector.id).future).ignore();
        ref.refresh(sectorPumpFutureProvider(sector.id).future).ignore();
      }
    }
    // TODO: refresh other sector related states
  }
}
