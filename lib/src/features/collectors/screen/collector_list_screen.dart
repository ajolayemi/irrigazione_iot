import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/app_router.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_sector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/screen/collector_expansion_list_tile.dart';
import 'package:irrigazione_iot/src/features/collectors/screen/collector_list/dismiss_collector_controller.dart';
import 'package:irrigazione_iot/src/features/collectors/widgets/empty_collector_widget.dart';
import 'package:irrigazione_iot/src/features/sectors/screen/sector_switch_controller.dart';
import 'package:irrigazione_iot/src/utils/async_value_ui.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/widgets/common_add_icon_button.dart';
import 'package:irrigazione_iot/src/widgets/common_sliver_list_skeleton.dart';

class CollectorListScreen extends ConsumerWidget {
  const CollectorListScreen({super.key});

  void _onAddCollectorPressed({
    required BuildContext context,
    required WidgetRef ref,
  }) {
    ref.read(sectorIdsOfCollectorBeingEditedProvider.notifier).state = [];
    ref.read(selectedSectorsIdProvider.notifier).state = [];
    context.pushNamed(
      AppRoute.addCollector.name,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// listen to switch controller state here as well because sector state
    /// can also be changed from this screen
    ref.listen(
      sectorSwitchControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    /// listen to collector dismissal controller state
    /// and show alert dialog if there is an error
    ref.listen(
      dismissCollectorControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    // todo: difference between filter in and filter out pressure and color base on certain level
    // todo: 0 - 0.2 - verde, 0.2 - 0.5 - arancione, sopra-  verde
    final loc = context.loc;
    final collectors = ref.watch(collectorListStreamProvider);
    return SafeArea(
        child: Scaffold(
      body: CustomScrollView(
        slivers: [
          AppSliverBar(
            title: loc.collectorPageTitle,
            actions: [
              CommonAddIconButton(
                onPressed: () => _onAddCollectorPressed(
                  context: context,
                  ref: ref,
                ),
              )
            ],
          ),
          AsyncValueSliverWidget(
            value: collectors,
            data: (collectors) {
              if (collectors.isEmpty) {
                return EmptyCollectorWidget(
                  onPressed: () =>
                      _onAddCollectorPressed(context: context, ref: ref),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    // collector shouldn't be null if we reach here
                    final collector = collectors[index]!;
                    return CollectorExpansionListTile(
                      collector: collector,
                    );
                  },
                  childCount: collectors.length,
                ),
              );
            },
            loading: () => const CommonSliverListSkeleton(
              hasLeading: false,
              hasSubtitle: false,
            ),
          )
        ],
      ),
    ));
  }
}
