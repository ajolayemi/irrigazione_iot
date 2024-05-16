import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/config/enums/form_types.dart';
import 'package:irrigazione_iot/src/features/weather_stations/screens/add_update_weather_station/add_update_weather_station_controller.dart';
import 'package:irrigazione_iot/src/features/weather_stations/screens/add_update_weather_station/add_update_weather_station_form_contents.dart';
import 'package:irrigazione_iot/src/shared/widgets/padded_safe_area.dart';
import 'package:irrigazione_iot/src/utils/async_value_ui.dart';

class AddUpdateWeatherStationForm extends ConsumerWidget {
  const AddUpdateWeatherStationForm({
    super.key,
    required this.formType,
    this.weatherStationId,
  });

  final GenericFormTypes formType;
  final String? weatherStationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      addUpdateWeatherStationControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    final controller = ref.watch(addUpdateWeatherStationControllerProvider);
    final isLoading = controller.isLoading;
    return PopScope(
      canPop: !isLoading,
      onPopInvoked: (didPop) {
        if (didPop) {
          debugPrint('User exited the weather station form');
        } else {
          debugPrint('User tried to exit the weather station form');
        }
      },
      child: Scaffold(
        body: PaddedSafeArea(
          child: AddUpdateWeatherStationFormContents(
            formType: formType,
            weatherStationId: weatherStationId,
          ),
        ),
      ),
    );
  }
}
