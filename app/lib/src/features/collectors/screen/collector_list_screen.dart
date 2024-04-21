import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/routes/routes_enums.dart';
import '../data/collector_repository.dart';
import '../data/collector_sector_repository.dart';
import 'collector_expansion_list_tile.dart';
import 'collector_list/dismiss_collector_controller.dart';
import '../widgets/empty_collector_widget.dart';
import '../../sectors/screen/sector_switch_controller.dart';
import '../../../utils/async_value_ui.dart';
import '../../../utils/extensions.dart';
import '../../../widgets/app_sliver_bar.dart';
import '../../../widgets/async_value_widget.dart';
import '../../../widgets/common_add_icon_button.dart';
import '../../../widgets/common_sliver_list_skeleton.dart';
import '../../../widgets/padded_safe_area.dart';

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
    final loc = context.loc;
    final collectors = ref.watch(collectorListStreamProvider);
    return PaddedSafeArea(
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
