import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station_statistic_history.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';
import 'package:irrigazione_iot/src/utils/extensions/string_extensions.dart';

class WeatherStationStatisticHistoryScreenContents extends StatelessWidget {
  const WeatherStationStatisticHistoryScreenContents({
    super.key,
    required this.histories,
    required this.locStatisticName,
    required this.keyForUm,
  });

  final List<WeatherStationStatisticHistory> histories;
  final String keyForUm;
  final String locStatisticName;

  @override
  Widget build(BuildContext context) {
    // TODO: add notification for max and min values
    // TODO: the max and min values should be placed at the beginning
    // TODO: of the list and highlighted in a different color
    // TODO: they should also be placed in their normal spaces and highlighted as well
    // TODO: max and min (for temperatura, umidità dell'aria, barometrica)
    // TODO: max (vento)
    // TODO: they should be clickable to be able to compare the said value in the
    // TODO: same time frame
    final loc = context.loc;
    return CustomScrollView(
      slivers: [
        AppSliverBar(
          title: loc.historyPageTitle,
        ),
        SliverFillRemaining(
          child: SingleChildScrollView(
            child: DataTable(
              dividerThickness: 0,
              columns: [
              DataColumn(
                  label: Text(loc.date),
                ),
                DataColumn(
                  label: Flexible(
                    child: Text(
                      locStatisticName,
                      overflow: TextOverflow.clip,
                      softWrap: true,
                    ),
                  ),
                ),
              ],
              rows: histories.map(
                (e) {
                  return DataRow(
                    cells: [
                      DataCell(
                        Text(
                          context.formatDate(e.createdAt),
                        ),
                      ),
                      DataCell(
                        Text(
                          '${e.value} ${keyForUm.getUmX(keyForUm)}',
                        ),
                      ),
                    ],
                  );
                },
              ).toList(),
            ),
          ),
        ),
    
      ],
    );
  }
}
