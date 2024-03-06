import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/sectors/data/specie_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/presentation/add_update_sector/responsive_select_screens_tile.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/widgets/async_value_widget.dart';

class SelectASpecieScreen extends ConsumerWidget {
  const SelectASpecieScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final species = ref.watch(specieNamesFutureProvider);
    return Scaffold(
      body: SafeArea(
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
