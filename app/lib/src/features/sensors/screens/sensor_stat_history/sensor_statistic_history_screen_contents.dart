import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:irrigazione_iot/src/features/sensors/models/sensor_statistic_history.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/utils/extensions/extensions.dart';
import 'package:irrigazione_iot/src/utils/extensions/string_extensions.dart';

class SensorStatisticHistoryScreenContents extends ConsumerWidget {
  const SensorStatisticHistoryScreenContents({
    super.key,
    required this.histories,
    required this.locStatisticName,
    required this.keyForUm,
  });

  final List<SensorStatisticHistory> histories;
  final String keyForUm;
  final String locStatisticName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    return CustomScrollView(
      slivers: [
        AppSliverBar(
          title: loc.historyPageTitle,
        ),
        SliverFillRemaining(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              dividerThickness: 0,
              columns: [
                const DataColumn(
                  label: Text('Date'),
                ),
                const DataColumn(
                  label: Text('Time'),
                ),
                DataColumn(
                  label: Flexible(
                      child: Text(
                    locStatisticName,
                    overflow: TextOverflow.clip,
                    softWrap: true,
                  )),
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
                          DateFormat.Hm().format(
                            e.createdAt!,
                          ),
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
        )
      ],
    );
  }
}
