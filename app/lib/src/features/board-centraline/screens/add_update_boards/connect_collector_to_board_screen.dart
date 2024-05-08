import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/features/board-centraline/data/board_repository.dart';
import 'package:irrigazione_iot/src/shared/models/radio_button_item.dart';
import 'package:irrigazione_iot/src/shared/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_add_icon_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/custom_sliver_connect_something_to.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_radio_list_tile.dart';
import 'package:irrigazione_iot/src/shared/widgets/sliver_adaptive_circular_indicator.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

class ConnectCollectorToBoardScreen extends ConsumerStatefulWidget {
  const ConnectCollectorToBoardScreen({
    super.key,
    this.previouslyConnectedCollectorId,
    this.selectedCollectorId,
    this.selectedCollectorName,
  });

  /// WHen the user navigates to this screen from the board details screen,
  /// the collector that was connected to the board is passed as the selected collector.
  /// This is done so that the user can see the collector that is already connected
  /// to the board.
  final String? previouslyConnectedCollectorId;

  /// The id of the collector that was selected during the previous navigation
  final String? selectedCollectorId;

  /// The name of the collector that was selected during the previous navigation
  final String? selectedCollectorName;

  @override
  ConsumerState<ConnectCollectorToBoardScreen> createState() =>
      _ConnectCollectorToBoardScreenState();
}

class _ConnectCollectorToBoardScreenState
    extends ConsumerState<ConnectCollectorToBoardScreen> {
  late RadioButtonItem _selectedCollector;

  @override
  void initState() {
    _selectedCollector = RadioButtonItem(
      value: widget.selectedCollectorId ?? '',
      label: widget.selectedCollectorName ?? '',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final availableCollectors = ref.watch(availableCollectorsFutureProvider(
      alreadyConnectedCollectorId: widget.previouslyConnectedCollectorId,
    ));

    return CustomSliverConnectSomethingTo(
      title: loc.connectCollectorToBoardPageTitle,
      actions: [
        CommonAddIconButton(
          onPressed: () => context.pushNamed(AppRoute.addCollector.name),
        )
      ],
      child: AsyncValueSliverWidget(
        value: availableCollectors,
        data: (collectors) {
          if (collectors == null || collectors.isEmpty) {
            return const SliverFillRemaining(
              child: Center(
                child: Text('No collectors found'),
              ),
            );
          }

          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final collector = collectors[index];
                return ResponsiveRadioListTile(
                  title: collector.name,
                  value: RadioButtonItem(
                    value: collector.id,
                    label: collector.name,
                  ),
                  groupValue: _selectedCollector,
                  onChanged: (newValue) => setState(() {
                    _selectedCollector = _selectedCollector.copyWith(
                      value: newValue?.value,
                      label: newValue?.label,
                    );
                  }),
                );
              },
              childCount: collectors.length,
            ),
          );
        },
        loading: () => const SliverAdaptiveCircularIndicator(),
      ),
      onCTAPressed: () =>
          context.popNavigator<RadioButtonItem>(_selectedCollector),
    );
  }
}
