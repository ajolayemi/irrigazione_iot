import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/config/routes/app_router.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/screen/collector_expansion_list_tile.dart';
import 'package:irrigazione_iot/src/features/collectors/widgets/empty_collector_widget.dart';
import 'package:irrigazione_iot/src/features/user_companies/data/user_companies_repository.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/app_bar_icon_buttons.dart';
import 'package:irrigazione_iot/src/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/widgets/common_sliver_list_skeleton.dart';

class CollectorListScreen extends ConsumerWidget {
  const CollectorListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // todo: if one of a sector is active, show status without expanding list
    // todo: show collector battery level in % 
    // todo: difference between filter in and filter out pressure and color base on certain level
    // todo: 0 - 0.2 - verde, 0.2 - 0.5 - arancione, sopra-  verde
    final loc = context.loc;
    final canEdit = ref.watch(companyUserRoleProvider).valueOrNull?.canEdit;
    final collectors = ref.watch(collectorListStreamProvider);
    return SafeArea(
        child: Scaffold(
      body: CustomScrollView(
        slivers: [
          AppSliverBar(
            title: loc.collectorPageTitle,
            actions: [
              AppBarIconButton(
                isVisibile: canEdit,
                onPressed: () => context.pushNamed(
                  AppRoute.addCollector.name,
                ),
                icon: Icons.add,
              )
            ],
          ),
          AsyncValueSliverWidget(
            value: collectors,
            data: (collectors) {
              if (collectors.isEmpty) {
                return const EmptyCollectorWidget();
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
