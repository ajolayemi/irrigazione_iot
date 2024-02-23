import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/constants/breakpoints.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/user_companies/application/user_companies_service.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/widgets/responsive_center.dart';

class PumpListScreen extends ConsumerWidget {
  const PumpListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSelectedCompanyByUser =
        ref.watch(currentTappedCompanyProvider).value;
    final companyPumps = ref.watch(companyPumpsStreamProvider(
      currentSelectedCompanyByUser?.id ?? '',
    ));
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AppSliverBar(
            title: context.loc.pumpPageTitle,
            actions: [
              IconButton.filled(
                onPressed: () {},
                icon: const Icon(
                  Icons.add,
                  size: 30,
                ),
              )
            ],
          ),
          AsyncValueSliverWidget(
            value: companyPumps,
            data: (pumps) => SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final pump = pumps[index];
                  return ResponsiveCenter(
                      maxContentWidth: Breakpoint.tablet,
                      child: InkWell(
                        onTap: () {
                          // todo navigate to pump details
                        },
                        child: ListTile(
                          title: Text(pump.name),
                          subtitleTextStyle: context.textTheme.titleSmall?.copyWith(
                            color: Colors.grey
                          
                          ),
                          subtitle: Text(
                            context.loc.pumpStatusLastUpdate(
                              DateTime.now(),
                              DateTime.now(),
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Consumer(
                                builder: (context, ref, child) {
                                  final pumpStatus = ref
                                      .watch(companyPumpStatusStreamProvider(
                                          pump.id))
                                      .value;
                                  return Switch.adaptive(
                                    value: pumpStatus ?? false,
                                    onChanged: (value) {
                                      // todo implement logic to update pump status
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ));
                },
                childCount: pumps.length,
              ),
            ),
          )
        ],
      ),
    );
  }
}
