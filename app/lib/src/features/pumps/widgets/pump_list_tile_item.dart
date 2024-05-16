import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump.dart';
import 'package:irrigazione_iot/src/features/pumps/screens/pump_list/dismiss_pump_controller.dart';
import 'package:irrigazione_iot/src/features/pumps/screens/pump_list/pump_status_controller.dart';
import 'package:irrigazione_iot/src/features/pumps/widgets/pump_list_tile_subtitle.dart';
import 'package:irrigazione_iot/src/features/pumps/widgets/pump_tile_title.dart';
import 'package:irrigazione_iot/src/features/pumps/widgets/pump_tile_trailing_button.dart';
import 'package:irrigazione_iot/src/shared/models/path_params.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_tablet_responsive_center.dart';
import 'package:irrigazione_iot/src/utils/custom_controller_state.dart';

class PumpListTileItem extends ConsumerWidget {
  const PumpListTileItem({
    super.key,
    required this.pump,
  });

  final Pump pump;

  void _onTap(BuildContext context) {
    final pathParams = PathParameters(
      id: pump.id,
    ).toJson();
    context.goNamed(
      AppRoute.pumpDetails.name,
      pathParameters: pathParams,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final globalLoadingState =
        ref.watch(pumpStatusControllerProvider).isGlobalLoading;
    final isDeleting = ref.watch(dismissPumpControllerProvider).isLoading;
    return CommonTabletResponsiveCenter(
        child: IgnorePointer(
      ignoring: isDeleting || globalLoadingState,
      child: InkWell(
        onTap: () => _onTap(context),
        child: ListTile(
          title: PumpTileTitle(pump: pump),
          subtitle: PumpListTileSubtitle(pump: pump),
          trailing: PumpTileTrailingButton(pump: pump),
        ),
      ),
    ));
  }
}
