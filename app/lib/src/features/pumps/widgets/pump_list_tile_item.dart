import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump.dart';
import 'package:irrigazione_iot/src/features/pumps/widgets/pump_list_tile_subtitle.dart';
import 'package:irrigazione_iot/src/features/pumps/widgets/pump_tile_title.dart';
import 'package:irrigazione_iot/src/features/pumps/widgets/pump_tile_trailing_button.dart';
import 'package:irrigazione_iot/src/shared/models/path_params.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_tablet_responsive_center.dart';

class PumpListTileItem extends StatelessWidget {
  const PumpListTileItem({
    super.key,
    required this.pump,
    required this.isDeleting,
    required this.stateIsLoading,
  });

  final Pump pump;
  final bool isDeleting;
  final bool stateIsLoading;

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
  Widget build(BuildContext context) {
    return CommonTabletResponsiveCenter(
        child: IgnorePointer(
      ignoring: isDeleting || stateIsLoading,
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
