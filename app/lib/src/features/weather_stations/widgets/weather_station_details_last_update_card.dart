import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

import 'package:irrigazione_iot/src/features/weather_stations/data/weather_station_measurement_repository.dart';
import 'package:irrigazione_iot/src/shared/widgets/details_tile_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_details_card.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

class WeatherStationDetailsLastUpdateCard extends ConsumerWidget {
  const WeatherStationDetailsLastUpdateCard({
    super.key,
    required this.weatherStationId,
  });

  final String weatherStationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    final lastMeasurement = ref.watch(
      lastWeatherStationMeasurementStreamProvider(weatherStationId),
    );
    final lastUpdated = lastMeasurement.valueOrNull?.createdAt;

    if (lastUpdated == null) {
      return ResponsiveDetailsCard(
        child: DetailTileWidget(
          title: loc.lastUpdated,
          subtitle: loc.notAvailable,
        ),
      );
    }

    return Timeago(
      builder: (_, value) => ResponsiveDetailsCard(
        child: DetailTileWidget(
          title: loc.lastUpdated,
          subtitle: context.customFormatDateTime(
            timeAgoDateString: value,
            dateTime: lastUpdated,
          ),
        ),
      ),
      date: lastUpdated,
      locale: context.locale,
    );
  }
}
