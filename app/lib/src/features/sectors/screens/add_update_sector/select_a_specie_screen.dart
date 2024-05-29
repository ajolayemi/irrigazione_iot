import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:irrigazione_iot/src/features/sectors/providers/select_a_specie_query_result.dart';
import 'package:irrigazione_iot/src/features/specie/data/specie_repository.dart';
import 'package:irrigazione_iot/src/shared/models/radio_button_item.dart';
import 'package:irrigazione_iot/src/shared/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_search_icon_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/custom_sliver_connect_something_to.dart';
import 'package:irrigazione_iot/src/shared/widgets/empty_search_result.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_radio_list_tile.dart';
import 'package:irrigazione_iot/src/shared/widgets/search_text_field.dart';
import 'package:irrigazione_iot/src/shared/widgets/sliver_adaptive_circular_indicator.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

class SelectASpecieScreen extends ConsumerStatefulWidget {
  const SelectASpecieScreen({
    super.key,
    this.selectedSpecieId,
    this.selectedSpecieName,
  });

  final String? selectedSpecieId;
  final String? selectedSpecieName;
  @override
  ConsumerState<SelectASpecieScreen> createState() =>
      _SelectASpecieScreenState();
}

class _SelectASpecieScreenState extends ConsumerState<SelectASpecieScreen> {
  bool _isSearching = false;
  late RadioButtonItem _selectedSpecie;

  @override
  void initState() {
    _selectedSpecie = RadioButtonItem(
      value: widget.selectedSpecieId ?? '',
      label: widget.selectedSpecieName ?? '',
    );
    super.initState();
  }

  void _onPressedSearchIcon() {
    if (_isSearching) {
      ref.read(selectASpecieQueryResultProvider.notifier).reset();
    }
    setState(() {
      _isSearching = !_isSearching;
    });
  }

  @override
  Widget build(BuildContext context) {
    final species = ref.watch(speciesStreamProvider);

    final queryResult = ref.watch(selectASpecieQueryResultProvider);
    final loc = context.loc;
    return CustomSliverConnectSomethingTo(
      subChild: _isSearching
          ? SearchTextField(
              onSearch:
                  ref.read(selectASpecieQueryResultProvider.notifier).search,
            )
          : null,
      actions: [
        CommonSearchIconButton(
          isVisibile: species.valueOrNull?.isNotEmpty ?? false,
          onPressed: _onPressedSearchIcon,
          isSearching: _isSearching,
        ),
      ],
      title: loc.selectASpecie,
      onCTAPressed: () => context.popNavigator(_selectedSpecie),
      child: AsyncValueSliverWidget(
        value: species,
        data: (data) {
          if (data != null && data.isNotEmpty && queryResult.isEmpty) {
            return const EmptySearchResult();
          }
          // TODO: replace this with more meaningful empty widget
          if (data == null || data.isEmpty) {
            return const SliverFillRemaining(
              child: Center(
                child: Text('No species found'),
              ),
            );
          }
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final specie = queryResult[index];

                return ResponsiveRadioListTile(
                  title: specie.name,
                  value: RadioButtonItem(
                    value: specie.id,
                    label: specie.name,
                  ),
                  groupValue: _selectedSpecie,
                  onChanged: (val) => setState(() {
                    _selectedSpecie = _selectedSpecie.copyWith(
                      value: val?.value,
                      label: val?.label,
                    );
                  }),
                );
              },
              childCount: queryResult.length,
            ),
          );
        },
        loading: () => const SliverAdaptiveCircularIndicator(),
      ),
    );
  }
}
