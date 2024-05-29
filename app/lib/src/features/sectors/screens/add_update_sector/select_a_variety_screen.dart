import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/sectors/providers/select_a_variety_query_result.dart';
import 'package:irrigazione_iot/src/features/variety/data/variety_repository.dart';
import 'package:irrigazione_iot/src/features/variety/models/variety.dart';
import 'package:irrigazione_iot/src/shared/models/radio_button_item.dart';
import 'package:irrigazione_iot/src/shared/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_search_icon_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/custom_sliver_connect_something_to.dart';
import 'package:irrigazione_iot/src/shared/widgets/empty_search_result.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_radio_list_tile.dart';
import 'package:irrigazione_iot/src/shared/widgets/search_text_field.dart';
import 'package:irrigazione_iot/src/shared/widgets/sliver_adaptive_circular_indicator.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

class SelectAVarietyScreen extends ConsumerStatefulWidget {
  const SelectAVarietyScreen({
    super.key,
    this.selectedVarietyId,
    this.selectedVarietyName,
  });

  final String? selectedVarietyId;
  final String? selectedVarietyName;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectAVarietyScreenState();
}

class _SelectAVarietyScreenState extends ConsumerState<SelectAVarietyScreen> {
  bool _isSearching = false;
  late RadioButtonItem _selectedVariety;

  @override
  void initState() {
    _selectedVariety = RadioButtonItem(
      value: widget.selectedVarietyId ?? '',
      label: widget.selectedVarietyName ?? '',
    );
    super.initState();
  }

  void _onPressedSearchIcon() {
    if (_isSearching) {
      ref.read(selectAVarietyQueryResultProvider.notifier).reset();
    }
    setState(() {
      _isSearching = !_isSearching;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final varieties = ref.watch(varietiesStreamProvider);

    final queryResult = ref.watch(selectAVarietyQueryResultProvider);
    return CustomSliverConnectSomethingTo(
      subChild: !_isSearching
          ? null
          : SearchTextField(
              onSearch:
                  ref.read(selectAVarietyQueryResultProvider.notifier).search,
            ),
      title: loc.selectAVarietyPageTitle,
      actions: [
        CommonSearchIconButton(
          isVisibile: varieties.valueOrNull?.isNotEmpty ?? false,
          onPressed: _onPressedSearchIcon,
          isSearching: _isSearching,
        )
      ],
      onCTAPressed: () => context.popNavigator(_selectedVariety),
      child: AsyncValueSliverWidget<List<Variety>?>(
        value: varieties,
        data: (data) {
          final hasData = data != null && data.isNotEmpty;
          if (hasData && queryResult.isEmpty) {
            return const EmptySearchResult();
          }
          // TODO: replace this with more meaningful empty widget
          if (!hasData) {
            return const SliverFillRemaining(
              child: Center(
                child: Text('No varieties found'),
              ),
            );
          }

          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final variety = queryResult[index];
                return ResponsiveRadioListTile(
                    title: variety.name,
                    value: RadioButtonItem(
                      value: variety.id,
                      label: variety.name,
                    ),
                    groupValue: _selectedVariety,
                    onChanged: (value) => setState(
                          () {
                            _selectedVariety = RadioButtonItem(
                              value: variety.id,
                              label: variety.name,
                            );
                          },
                        ));
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
