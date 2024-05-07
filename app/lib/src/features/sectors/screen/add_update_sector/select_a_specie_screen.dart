import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/specie/data/specie_repository.dart';
import 'package:irrigazione_iot/src/shared/models/radio_button_item.dart';
import 'package:irrigazione_iot/src/shared/widgets/custom_sliver_connect_something_to.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_radio_list_tile.dart';
import 'package:irrigazione_iot/src/shared/widgets/sliver_adaptive_circular_indicator.dart';
import 'package:irrigazione_iot/src/utils/extensions/extensions.dart';
import 'package:irrigazione_iot/src/shared/widgets/async_value_widget.dart';

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
  late RadioButtonItem _selectedSpecie;

  @override
  void initState() {
    _selectedSpecie = RadioButtonItem(
      value: widget.selectedSpecieId ?? '',
      label: widget.selectedSpecieName ?? '',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final species = ref.watch(
      speciesStreamProvider(
          previouslySelectedSpecieId: widget.selectedSpecieId),
    );
    final loc = context.loc;
    return CustomSliverConnectSomethingTo(
      title: loc.selectASpecie,
      onCTAPressed: () => context.popNavigator(_selectedSpecie),
      child: AsyncValueSliverWidget(
        value: species,
        data: (species) {
          // TODO: replace this with more meaningful empty widget
          if (species == null || species.isEmpty) {
            return const SliverFillRemaining(
              child: Center(
                child: Text('No species found'),
              ),
            );
          }
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final specie = species[index];

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
              childCount: species.length,
            ),
          );
        },
        loading: () => const SliverAdaptiveCircularIndicator(),
      ),
    );
  }
}
