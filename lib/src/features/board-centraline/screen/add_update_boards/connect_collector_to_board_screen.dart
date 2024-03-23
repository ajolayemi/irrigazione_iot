import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/enums/button_types.dart';
import 'package:irrigazione_iot/src/config/routes/app_router.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/board-centraline/data/board_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/widgets/empty_collector_widget.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/app_cta_button.dart';
import 'package:irrigazione_iot/src/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/widgets/common_add_icon_button.dart';
import 'package:irrigazione_iot/src/widgets/responsive_radio_list_tile.dart';
import 'package:irrigazione_iot/src/widgets/sliver_adaptive_circular_indicator.dart';

class ConnectCollectorToBoardScreen extends ConsumerWidget {
  const ConnectCollectorToBoardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    final availableCollectors =
        ref.watch(collectorsNotConnectedToABoardStreamProvider);
    final selectedCollectorId = ref.watch(selectedCollectorIdProvider);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  AppSliverBar(
                    title: loc.connectCollectorToBoardPageTitle,
                    actions: [
                      CommonAddIconButton(
                        onPressed: () =>
                            context.pushNamed(AppRoute.addCollector.name),
                      )
                    ],
                  ),
                  AsyncValueSliverWidget(
                    value: availableCollectors,
                    data: (collectors) {
                      if (collectors.isEmpty) {
                        return Consumer(builder: (context, ref, child) {
                          // check to see if the current company generally has collectors
                          final hasCollectors = ref
                                  .watch(collectorListStreamProvider)
                                  .valueOrNull
                                  ?.isNotEmpty ??
                              false;
                          return EmptyCollectorWidget(
                            alternativeMessage: hasCollectors
                                ? loc.allCollectorsAreConnectedToABoard
                                : null,
                          );
                        });
                      }

                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final collector = collectors[index]!;
                            return ResponsiveRadioListTile(
                              title: Text(collector.name),
                              value: collector.id,
                              groupValue: selectedCollectorId ?? '',
                              onChanged: (newValue) {
                                ref
                                    .read(selectedCollectorIdProvider.notifier)
                                    .state = newValue;
                              },
                            );
                          },
                          childCount: collectors.length,
                        ),
                      );
                    },
                    loading: () => const SliverAdaptiveCircularIndicator(),
                  ),
                ],
              ),
            ),

            // button to confirm selection
            Visibility(
              visible: availableCollectors.valueOrNull?.isNotEmpty ?? false,
              child: SliverCTAButton(
                text: loc.genericConfirmButtonLabel,
                buttonType: ButtonType.primary,
                onPressed: () => context.popNavigator(selectedCollectorId),
              ),
            ),
            gapH32,
          ],
        ),
      ),
    );
  }
}