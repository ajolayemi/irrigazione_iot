import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station_statistic_history.dart';
import 'package:irrigazione_iot/src/features/weather_stations/data/weather_station_statistic_history_repository.dart';
import 'package:irrigazione_iot/src/features/weather_stations/screens/weather_station_stat_history/weather_station_statistic_history_screen_contents.dart';
import 'package:irrigazione_iot/src/shared/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/empty_data_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/padded_safe_area.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

/// Displays the history of a weather station's statistics.
/// For example, air temperature, air humidity, light intensity, barometric pressure, etc
class WeatherStationStatisticHistoryScreen extends ConsumerWidget {
  const WeatherStationStatisticHistoryScreen({
    super.key,
    required this.columnName,
    required this.statisticName,
    required this.weatherStationId,
  });

  /// The column name of the statistic to display, i.e the name
  /// given to it in database
  final String columnName;

  /// The name of the statistic to display, i.e the name
  /// This is a user readable name to understand what statistic they're currently
  /// viewing
  final String statisticName;

  /// The id of the weather station whose statistic history is currently being displayed
  final String weatherStationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    final statData = ref.watch(
        weatherStationStatisticsFutureProvider(weatherStationId, columnName));
    return Scaffold(
      body: PaddedSafeArea(
        child: AsyncValueSliverWidget<List<WeatherStationStatisticHistory>?>(
          value: statData,
          data: (data) {
            if (data == null || data.isEmpty) {
              return EmptyDataWidget(
                message: loc.noHistory,
                buttonText: '',
                onPressed: () {},
              );
            }

            return WeatherStationStatisticHistoryScreenContents(
              histories: data,
              locStatisticName: statisticName,
              keyForUm: columnName,
            );
          },
          loading: () => const CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}
