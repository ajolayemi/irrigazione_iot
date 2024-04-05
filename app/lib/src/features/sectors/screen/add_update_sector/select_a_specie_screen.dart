import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/specie_repository.dart';
import 'responsive_select_screens_tile.dart';
import '../../../../utils/extensions.dart';
import '../../../../widgets/app_sliver_bar.dart';
import '../../../../widgets/async_value_widget.dart';
import '../../../../widgets/padded_safe_area.dart';

class SelectASpecieScreen extends ConsumerWidget {
  const SelectASpecieScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final species = ref.watch(specieNamesFutureProvider);
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
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final specie = species[index];
        
                        return ResponsiveSelectScreensTile(
                            title: specie,
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
