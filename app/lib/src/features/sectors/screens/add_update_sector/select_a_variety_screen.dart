import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/variety/data/variety_repository.dart';
import 'package:irrigazione_iot/src/features/variety/models/variety.dart';
import 'package:irrigazione_iot/src/shared/models/radio_button_item.dart';
import 'package:irrigazione_iot/src/shared/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/custom_sliver_connect_something_to.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_radio_list_tile.dart';
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
  late RadioButtonItem _selectedVariety;

  @override
  void initState() {
    _selectedVariety = RadioButtonItem(
      value: widget.selectedVarietyId ?? '',
      label: widget.selectedVarietyName ?? '',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final varieties = ref.watch(
      varietiesStreamProvider(
          previouslySelectedVarietyId: widget.selectedVarietyId),
    );

    return CustomSliverConnectSomethingTo(
      title: loc.selectAVarietyPageTitle,
      onCTAPressed: () => context.popNavigator(_selectedVariety),
      child: AsyncValueSliverWidget<List<Variety>?>(
        value: varieties,
        data: (varieties) {
          // TODO: replace this with more meaningful empty widget
          if (varieties == null || varieties.isEmpty) {
            return const SliverFillRemaining(
              child: Center(
                child: Text('No varieties found'),
              ),
            );
          }

          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final variety = varieties[index];
                return ResponsiveRadioListTile(
                  title: variety.name,
                  value: RadioButtonItem(
                    value: variety.id,
                    label: variety.name,
                  ),
                  groupValue: _selectedVariety,
                  onChanged: (value) {
                    setState(
                      () {
                        _selectedVariety = RadioButtonItem(
                          value: variety.id,
                          label: variety.name,
                        );
                      },
                    );
                  },
                );
              },
              childCount: varieties.length,
            ),
          );
        },
        loading: () => const SliverAdaptiveCircularIndicator(),
      ),
    );
  }
}
