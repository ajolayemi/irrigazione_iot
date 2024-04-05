import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/enums/roles.dart';
import '../../../../config/routes/routes_enums.dart';
import '../../data/pump_repository.dart';
import '../../model/pump.dart';
import 'pump_details_list.dart';
import 'pump_details_list_skeleton.dart';
import '../pump_status_switch_controller.dart';
import '../../../company_users/data/company_users_repository.dart';
import '../../../../utils/async_value_ui.dart';
import '../../../../widgets/app_bar_icon_buttons.dart';
import '../../../../widgets/app_sliver_bar.dart';
import '../../../../widgets/async_value_widget.dart';

class PumpDetailsScreen extends ConsumerWidget {
  const PumpDetailsScreen({
    super.key,
    required this.pumpId,
  });

  final PumpID pumpId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // TODO: divide in two sections of ExpansionTile
    // TODO: section 1 - pump charasterics
    // TODO: section 2 - dati statistici ()
    // TODO: last erogation stays as a single card
    ref.listen(
      pumpStatusSwitchControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    final canEdit = ref.watch(companyUserRoleProvider).valueOrNull?.canEdit;

    // This is used to prevent user from exiting the screen while the pump is
    // being switched on or off (i.e in loading state)
    final aPumpIsCurrentlyLoading = ref.watch(
        pumpStatusSwitchControllerProvider.select(
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