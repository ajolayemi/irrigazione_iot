import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:irrigazione_iot/src/config/enums/button_types.dart';
import 'package:irrigazione_iot/src/config/enums/form_types.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/constants/app_constants.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_repository.dart';
import 'package:irrigazione_iot/src/features/weather_stations/data/weather_station_repository.dart';
import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station.dart';
import 'package:irrigazione_iot/src/features/weather_stations/screens/add_update_weather_station/add_update_weather_station_controller.dart';
import 'package:irrigazione_iot/src/shared/models/query_params.dart';
import 'package:irrigazione_iot/src/shared/models/radio_button_item.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_cta_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_form_suffix_icon.dart';
import 'package:irrigazione_iot/src/shared/widgets/form_title_and_field.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_sliver_form.dart';
import 'package:irrigazione_iot/src/utils/app_form_error_texts_extension.dart';
import 'package:irrigazione_iot/src/utils/app_form_validators.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

class AddUpdateWeatherStationFormContents extends ConsumerStatefulWidget {
  const AddUpdateWeatherStationFormContents({
    super.key,
    this.weatherStationId,
    required this.formType,
  });

  final String? weatherStationId;
  final GenericFormTypes formType;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddUpdateWeatherStationFormContentsState();
}

class _AddUpdateWeatherStationFormContentsState
    extends ConsumerState<AddUpdateWeatherStationFormContents>
    with AppFormValidators {
  bool get _isUpdating => widget.formType.isUpdating;

  final _node = FocusScopeNode();
  final _formKey = GlobalKey<FormState>();

  var _submitted = false;

  final _nameController = TextEditingController();
  final _euiController = TextEditingController();
  final _selectedSectorController = TextEditingController();

  String get _name => _nameController.text;
  String get _eui => _euiController.text;
  String get _sector => _selectedSectorController.text;

  static const _nameKey = Key('weatherStationNameField');
  static const _euiKey = Key('weatherStationEUIField');
  static const _weatherStationSectorKey = Key('weatherStationSectorField');

  WeatherStation? _initialWeatherStation = const WeatherStation.empty();

  RadioButtonItem? _radioButtonSelectedSector;

  @override
  void initState() {
    if (_isUpdating) {
      final weatherStation =
          ref.read(weatherStationStreamProvider(widget.weatherStationId!));
      final value = weatherStation.valueOrNull;

      _initialWeatherStation = value;

      _nameController.text = value?.name ?? '';
      _euiController.text = value?.eui ?? '';

      if (value != null) {
        // Get the sector that this weather station is connected to
        final sector = ref.read(sectorStreamProvider(value.sectorId));
        final sectorValue = sector.valueOrNull;
        _radioButtonSelectedSector = RadioButtonItem(
          value: sectorValue?.id ?? '',
          label: sectorValue?.name ?? '',
        );

        _selectedSectorController.text = sectorValue?.name ?? '';
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _euiController.dispose();
    _selectedSectorController.dispose();
    _node.dispose();
    super.dispose();
  }

  void _onTappedConnectSector() async {
    final queryParam = QueryParameters(
      id: _radioButtonSelectedSector?.value,
      name: _sector,
    ).toJson();
    final selectedSector = await context.pushNamed<RadioButtonItem>(
      AppRoute.connectSectorToWeatherStation.name,
      queryParameters: queryParam,
    );

    if (selectedSector != null) {
      _radioButtonSelectedSector = selectedSector;
      _selectedSectorController.text = selectedSector.label;
    }
  }

  /// Validates name and device EUI fields
  void _uniqueFieldsEditingComplete(
      {required List<String?> existingValues,
      required int maxLength,
      required String value,
      String? initialValue}) {
    if (canSubmitFormNameFields(
      value: value,
      maxLength: maxLength,
      namesToCompareAgainst: existingValues,
      initialValue: initialValue,
    )) {
      _node.nextFocus();
    }
  }

  String? _uniqueFieldsErrorText(
      {required List<String?> existingValues,
      required int maxLength,
      required String value,
      String? initialValue}) {
    if (!_submitted) return null;
    final errorKey = getFormNameFieldErrorKey(
      value: value,
      maxLength: maxLength,
      namesToCompareAgainst: existingValues,
      initialValue: initialValue,
    );

    final fieldName = context.loc.nSensors(1);
    return context.getLocalizedErrorText(
      errorKey: errorKey,
      fieldName: fieldName,
      maxFieldLength: maxLength,
    );
  }

  void _nonEmptyFieldsEditingComplete(String value) {
    if (canSubmitNonEmptyFields(value: value)) {
      _node.nextFocus();
    }
  }

  String? _nonEmptyFieldsErrorText(String value) {
    if (!_submitted) return null;
    final errorKey = getNonEmptyFieldsErrorKey(value: value);
    return context.getLocalizedErrorText(errorKey: errorKey);
  }

  void _popScreen() => context.popNavigator();

  Future<void> _submit() async {
    _node.unfocus();
    setState(() => _submitted = true);
    if (_formKey.currentState!.validate()) {
      final canContinue = await context.showSaveUpdateDialog(
        isUpdating: _isUpdating,
        what: context.loc.nWeatherStations(1),
      );

      if (!canContinue) return;

      final data = _initialWeatherStation?.copyWith(
        name: _name,
        eui: _eui,
        sectorId: _radioButtonSelectedSector?.value,
      );

      bool success = false;

      if (_isUpdating) {
        success = await ref
            .read(addUpdateWeatherStationControllerProvider.notifier)
            .updateWeatherStation(data);
      } else {
        success = await ref
            .read(addUpdateWeatherStationControllerProvider.notifier)
            .createWeatherStation(data);
      }

      if (success) {
        _popScreen();
        return;
      }
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(addUpdateWeatherStationControllerProvider);
    final isLoading = controller.isLoading;
    final loc = context.loc;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              AppSliverBar(
                title: _isUpdating
                    ? loc.updateWeatherStationPageTitle
                    : loc.addWeatherStationPageTitle,
              ),
              ResponsiveSliverForm(
                node: _node,
                formKey: _formKey,
                children: [
                  // name field
                  Consumer(
                    builder: (context, ref, child) {
                      final usedNames = ref.watch(
                        usedWeatherStationNamesStreamProvider,
                      );
                      final values = usedNames.valueOrNull ?? [];
                      return FormTitleAndField(
                        enabled: !isLoading,
                        maxLength: AppConstants.maxWeatherStationNameLength,
                        fieldKey: _nameKey,
                        fieldTitle: loc.nameFormFieldTitle,
                        fieldHintText: loc.weatherStationNameHintText,
                        fieldController: _nameController,
                        onEditingComplete: () => _uniqueFieldsEditingComplete(
                          existingValues: values,
                          maxLength: AppConstants.maxWeatherStationNameLength,
                          value: _name,
                          initialValue: _initialWeatherStation?.name,
                        ),
                        validator: (_) => _uniqueFieldsErrorText(
                          existingValues: values,
                          maxLength: AppConstants.maxWeatherStationNameLength,
                          value: _name,
                          initialValue: _initialWeatherStation?.name,
                        ),
                      );
                    },
                  ),

                  gapH16,

                  // device EUI field
                  Consumer(
                    builder: (context, ref, child) {
                      final usedEuis =
                          ref.watch(usedWeatherStationEUIsStreamProvider);
                      final values = usedEuis.valueOrNull ?? [];
                      return FormTitleAndField(
                        enabled: !isLoading,
                        fieldKey: _euiKey,
                        maxLength: AppConstants.maxWeatherStationEuiLength,
                        fieldTitle: loc.deviceEui,
                        fieldController: _euiController,
                        fieldHintText: loc.weatherStationEuiHintText,
                        onEditingComplete: () => _uniqueFieldsEditingComplete(
                          existingValues: values,
                          maxLength: AppConstants.maxWeatherStationEuiLength,
                          value: _eui,
                          initialValue: _initialWeatherStation?.eui,
                        ),
                        validator: (_) => _uniqueFieldsErrorText(
                          existingValues: values,
                          maxLength: AppConstants.maxWeatherStationEuiLength,
                          value: _eui,
                          initialValue: _initialWeatherStation?.eui,
                        ),
                      );
                    },
                  ),
                  gapH16,

                  // sector field
                  FormTitleAndField(
                    enabled: !isLoading,
                    fieldKey: _weatherStationSectorKey,
                    fieldController: _selectedSectorController,
                    canRequestFocus: false,
                    keyboardType: TextInputType.none,
                    onTap: _onTappedConnectSector,
                    suffixIcon: CommonFormSuffixIcon(
                      onPressed: _onTappedConnectSector,
                    ),
                    fieldTitle: loc.connectedSector,
                    fieldHintText: loc.selectAnOptionHintText,
                    validator: (_) => _nonEmptyFieldsErrorText(_sector),
                    onEditingComplete: () =>
                        _nonEmptyFieldsEditingComplete(_sector),
                  )
                ],
              ),
            ],
          ),
        ),
        gapH16,
        SliverCTAButton(
          text: _isUpdating
              ? loc.genericUpdateButtonLabel
              : loc.genericSaveButtonLabel,
          buttonType: ButtonType.primary,
          onPressed: () async => await _submit(),
        ),
        gapH16,
      ],
    );
  }
}
