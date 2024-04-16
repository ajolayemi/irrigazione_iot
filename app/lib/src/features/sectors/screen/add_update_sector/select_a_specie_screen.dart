import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/specie/data/specie_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/screen/add_update_sector/responsive_select_screens_tile.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/shared/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/padded_safe_area.dart';

class SelectASpecieScreen extends ConsumerWidget {
  const SelectASpecieScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final species = ref.watch(specieFutureProvider);
    return Scaffold(
      body: PaddedSafeArea(
        child: CustomScrollView(
          slivers: [
            AppSliverBar(
              title: context.loc.selectASpecie,
            ),
            AsyncValueSliverWidget(
                value: species,
                loading: () => const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
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

                        return ResponsiveSelectScreensTile(
                            title: specie.name,
                            onTap: () {
                              Navigator.of(context).pop(specie);
                            });
                      },
                      childCount: species.length,
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
