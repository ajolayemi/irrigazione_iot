import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/screens/pump_list/pump_search_query_result.dart';
import 'package:irrigazione_iot/src/features/pumps/widgets/empty_pump_widget.dart';
import 'package:irrigazione_iot/src/shared/models/radio_button_item.dart';
import 'package:irrigazione_iot/src/shared/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_add_icon_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_search_icon_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/custom_sliver_connect_something_to.dart';
import 'package:irrigazione_iot/src/shared/widgets/empty_search_result.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_radio_list_tile.dart';
import 'package:irrigazione_iot/src/shared/widgets/search_text_field.dart';
import 'package:irrigazione_iot/src/shared/widgets/sliver_adaptive_circular_indicator.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

class ConnectPumpToSector extends ConsumerStatefulWidget {
  const ConnectPumpToSector(
      {super.key,
      this.selectedPumpId,
      this.selectedPumpName,
      this.pumpIdPreviouslyConnectedToSector});

  /// When the user navigates to this screen from the sector details screen,
  /// the pump that was connected to the sector is passed as the selected pump.
  /// This is done so that the user can see the pump that is already connected
  /// to the sector.
  final String? pumpIdPreviouslyConnectedToSector;

  /// The id of the pump that was selected during the previous navigation
  final String? selectedPumpId;

  /// The name of the pump that was selected during the previous navigation
  final String? selectedPumpName;

  @override
  ConsumerState<ConnectPumpToSector> createState() =>
      _ConnectPumpToSectorState();
}

class _ConnectPumpToSectorState extends ConsumerState<ConnectPumpToSector> {
  bool _isSearching = false;
  late RadioButtonItem _selectedPump;

  @override
  void initState() {
    _selectedPump = RadioButtonItem(
      value: widget.selectedPumpId ?? '',
      label: widget.selectedPumpName ?? '',
    );
    super.initState();
  }

  void _onPressedSearchIcon() {
    if (_isSearching) {
      ref.read(pumpSearchQueryResultProvider.notifier).reset();
    }
    setState(() {
      _isSearching = !_isSearching;
    });
  }

  @override
  Widget build(BuildContext context) {
    final availablePumps = ref.watch(companyPumpsFutureProvider).valueOrNull;
    final loc = context.loc;

    final queryResult = ref.watch(pumpSearchQueryResultProvider);

    return CustomSliverConnectSomethingTo(
      subChild: _isSearching
          ? SearchTextField(
              onSearch:
                  ref.read(pumpSearchQueryResultProvider.notifier).search,
            )
          : null,
      title: loc.connectPumpToSectorPageTile,
      actions: [
        CommonSearchIconButton(
          isVisibile: availablePumps?.isNotEmpty ?? false,
          onPressed: _onPressedSearchIcon,
          isSearching: _isSearching,
        ),
        CommonAddIconButton(
          onPressed: () => context.pushNamed(
            AppRoute.addPump.name,
          ),
        ),
      ],
      child: AsyncValueSliverWidget(
        value: queryResult,
        data: (filterResult) {
          final hasPumpsOriginally =
              availablePumps != null && availablePumps.isNotEmpty;

          final filterIsEmpty = filterResult?.isEmpty ?? true;

          if (hasPumpsOriginally && filterIsEmpty) {
            return const EmptySearchResult();
          }
          if (!hasPumpsOriginally) {
            return const EmptyPumpWidget();
          }

          // it should be save to assume that the pumps are not null here
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final pump = filterResult![index];
                return ResponsiveRadioListTile(
                  title: pump.name,
                  value: RadioButtonItem(
                    value: pump.id,
                    label: pump.name,
                  ),
                  groupValue: _selectedPump,
                  onChanged: (val) => setState(() {
                    _selectedPump = _selectedPump.copyWith(
                      value: val?.value,
                      label: val?.label,
                    );
                  }),
                );
              },
              childCount: filterResult?.length,
            ),
          );
        },
        loading: () => const SliverAdaptiveCircularIndicator(),
      ),
      onCTAPressed: () => context.popNavigator(_selectedPump),
    );
  }
}
