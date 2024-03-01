import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/app_router.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/domain/pump.dart';
import 'package:irrigazione_iot/src/features/pumps/presentation/pump_details/pump_details_sliver_list.dart';
import 'package:irrigazione_iot/src/features/pumps/presentation/pump_details/pump_details_sliver_list_skeleton.dart';
import 'package:irrigazione_iot/src/features/pumps/presentation/pump_status/pump_status_switch_controller.dart';
import 'package:irrigazione_iot/src/utils/async_value_ui.dart';
import 'package:irrigazione_iot/src/widgets/app_bar_icon_buttons.dart';
import 'package:irrigazione_iot/src/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/widgets/async_value_widget.dart';

class PumpDetailsScreen extends ConsumerWidget {
  const PumpDetailsScreen({
    super.key,
    required this.pumpId,
  });

  final PumpID pumpId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      pumpStatusSwitchControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

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
                // todo this button should be visible only when the current user operating
                // todo isn't a regular user
                AppBarIconButton(
                  onPressed: () => context.goNamed(AppRoute.updatePump.name, pathParameters: {
                    'pumpId': pump.value?.id ?? '',
                  }),
                  icon: Icons.edit,
                ) // todo add logic to edit existing pump details
              ],
            ),
            AsyncValueSliverWidget(
                value: pump,
                loading: () => const PumpDetailsSliverListSkeleton(),
                data: (pump) {
                  if (pump == null) return const SliverToBoxAdapter();
                  return PumpDetailsSliverList(
                    pump: pump,
                  );
                }),
          ],
        ),
      ),
    );
  }
}
