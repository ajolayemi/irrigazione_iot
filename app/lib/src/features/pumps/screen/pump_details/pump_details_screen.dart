import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/features/company_users/data/company_users_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/screen/pump_details/pump_details_list.dart';
import 'package:irrigazione_iot/src/features/pumps/screen/pump_details/pump_details_list_skeleton.dart';
import 'package:irrigazione_iot/src/features/pumps/screen/pump_list/pump_status_controller.dart';
import 'package:irrigazione_iot/src/utils/async_value_ui.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_bar_icon_buttons.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/shared/widgets/async_value_widget.dart';


class PumpDetailsScreen extends ConsumerWidget {
  const PumpDetailsScreen({
    super.key,
    required this.pumpId,
  });

  final String pumpId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // TODO: divide in two sections of ExpansionTile
    // TODO: section 1 - pump charasterics
    // TODO: section 2 - dati statistici ()
    // TODO: last erogation stays as a single card
    ref.listen(
      pumpStatusControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    final canEdit = ref.watch(companyUserRoleProvider).valueOrNull?.canEdit;

    // This is used to prevent user from exiting the screen while the pump is
    // being switched on or off (i.e in loading state)
    final aPumpIsCurrentlyLoading = ref.watch(
        pumpStatusControllerProvider.select(
            (state) => (state.value?.isLoading ?? false) && !state.hasError));
    final pump = ref.watch(pumpStreamProvider(pumpId));
    return PopScope(
      canPop: !aPumpIsCurrentlyLoading,
      onPopInvoked: (didPop) {
        if (!didPop) {
          // todo show a toast or snackbar to inform the user that the pump is currently being switched on or off
          debugPrint(
              "You can't exit the screen while the pump is being switched on or off");
        }
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            AppSliverBar(
              title: pump.value?.name ?? 'N/A',
              actions: [
                AppBarIconButton(
                  isVisibile: canEdit,
                  onPressed: () => context.pushNamed(
                    AppRoute.updatePump.name,
                    pathParameters: {
                      'pumpId': pump.value?.id ?? '',
                    },
                  ),
                  icon: Icons.edit,
                )
              ],
            ),
            AsyncValueSliverWidget(
                value: pump,
                loading: () => const PumpDetailsSliverListSkeleton(),
                data: (pump) {
                  if (pump == null) return const SliverToBoxAdapter();
                  return PumpDetailsList(
                    pump: pump,
                  );
                }),
          ],
        ),
      ),
    );
  }
}
