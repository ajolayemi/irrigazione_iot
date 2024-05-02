import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/screen/pump_details/pump_details_list.dart';
import 'package:irrigazione_iot/src/features/pumps/screen/pump_details/pump_details_list_skeleton.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/shared/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_edit_icon_button.dart';

class PumpDetailsScreen extends ConsumerWidget {
  const PumpDetailsScreen({
    super.key,
    required this.pumpId,
  });

  final String pumpId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pump = ref.watch(pumpStreamProvider(pumpId));
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AppSliverBar(
            title: pump.value?.name ?? '',
            actions: [
              CommonEditIconButton(
                onPressed: () {
                  context.pushNamed(
                    AppRoute.updatePump.name,
                    pathParameters: {
                      'pumpId': pump.value?.id ?? '',
                    },
                  );
                },
              ),
            ],
          ),
          AsyncValueSliverWidget(
            value: pump,
            data: (pump) => pump == null
                ? const SliverToBoxAdapter()
                : PumpDetailsList(pump: pump),
            loading: () => const PumpDetailsSliverListSkeleton(),
          ),
        ],
      ),
    );
  }
}
