import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/weather_stations/data/weather_station_repository.dart';
import 'package:irrigazione_iot/src/features/weather_stations/screens/weather_station_details/weather_station_details_screen_contents.dart';
import 'package:irrigazione_iot/src/shared/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/empty_placeholder_widget.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

class WeatherStationDetailsScreen extends ConsumerWidget {
  const WeatherStationDetailsScreen({
    super.key,
    required this.weatherStationId,
  });

  final String weatherStationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    final weatherStation =
        ref.watch(weatherStationStreamProvider(weatherStationId));
    return Scaffold(
      body: AsyncValueSliverWidget(
        value: weatherStation,
        data: (data) {
          if (data == null) {
            return EmptyPlaceholderWidget(message: loc.notAvailable);
          }
          return WeatherStationDetailsScreenContents(weatherStation: data);
        },
        loading: () => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}
