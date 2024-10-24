import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:irrigazione_iot/src/config/enums/button_types.dart';
import 'package:irrigazione_iot/src/config/enums/form_types.dart';
import 'package:irrigazione_iot/src/config/enums/irrigation_enums.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/constants/app_constants.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_pump_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector.dart';
import 'package:irrigazione_iot/src/features/sectors/screens/add_update_sector/add_update_sector_controller.dart';
import 'package:irrigazione_iot/src/features/specie/data/specie_repository.dart';
import 'package:irrigazione_iot/src/features/variety/data/variety_repository.dart';
import 'package:irrigazione_iot/src/shared/models/query_params.dart';
import 'package:irrigazione_iot/src/shared/models/radio_button_item.dart';
import 'package:irrigazione_iot/src/shared/widgets/alert_dialogs.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_cta_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_form_suffix_icon.dart';
import 'package:irrigazione_iot/src/shared/widgets/form_field_checkbox.dart';
import 'package:irrigazione_iot/src/shared/widgets/form_title_and_field.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_sliver_form.dart';
import 'package:irrigazione_iot/src/utils/app_form_error_texts_extension.dart';
import 'package:irrigazione_iot/src/utils/app_form_validators.dart';
import 'package:irrigazione_iot/src/utils/async_value_ui.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';
import 'package:irrigazione_iot/src/utils/numeric_fields_text_type.dart';

class AddUpdateSectorFormContents extends ConsumerStatefulWidget {
  const AddUpdateSectorFormContents(
      {super.key, required this.formType, this.sectorId});

  final String? sectorId;
  final GenericFormTypes formType;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddUpdateSectorFormContentsState();
}

class _AddUpdateSectorFormContentsState
    extends ConsumerState<AddUpdateSectorFormContents> with AppFormValidators {
  // general variables
  final _node = FocusScopeNode();
  final _formKey = GlobalKey<FormState>();

  // local variable used to apply AutovalidateMode.onUserInteraction and show
  // error hints only when the form has been submitted
  // For more details on how this is implemented, see:
  // https://codewithandrea.com/articles/flutter-text-field-form-validation/
  var _submitted = false;

  // form fields controllers
  final _nameController = TextEditingController();
  final _specieController = TextEditingController();
  final _varietyController = TextEditingController();
  final _areaController = TextEditingController();
  final _numOfPlantsController = TextEditingController();
  final _unitConsumptionController = TextEditingController();
  final _irrigationSystemController = TextEditingController();
  final _irrigationSourceController = TextEditingController();
  final _turnOnCommandController = TextEditingController();
  final _turnOffCommandController = TextEditingController();
  final _notesController = TextEditingController();
  final _selectedPumpController = TextEditingController();
  final _mqttMsgNameController = TextEditingController();

  // form field values
  String get name => _nameController.text;
  String get specie => _specieController.text;
  String get variety => _varietyController.text;
  String get area => _areaController.text;
  String get numOfPlants => _numOfPlantsController.text;
  String get unitConsumption => _unitConsumptionController.text;
  String get irrigationSystem => _irrigationSystemController.text;
  String get irrigationSource => _irrigationSourceController.text;
  String get turnOnCommand => _turnOnCommandController.text;
  String get turnOffCommand => _turnOffCommandController.text;
  String get notes => _notesController.text;
  String get selectedPump => _selectedPumpController.text;
  String get mqttMsgName => _mqttMsgNameController.text;

  // Keys for testing
  static const _nameFieldKey = Key('sectorNameField');
  static const _specieFieldKey = Key('sectorSpecieField');
  static const _varietyFieldKey = Key('sectorVarietyField');
  static const _areaFieldKey = Key('sectorAreaField');
  static const _numOfPlantsFieldKey = Key('sectorNumOfPlantsField');
  static const _unitConsumptionFieldKey = Key('sectorUnitConsumptionField');
  static const _irrigationSystemFieldKey = Key('sectorIrrigationSystemField');
  static const _irrigationSourceFieldKey = Key('sectorIrrigationSourceField');
  static const _turnOnCommandFieldKey = Key('sectorTurnOnCommandField');
  static const _turnOffCommandFieldKey = Key('sectorTurnOffCommandField');
  static const _connectedPumpsFieldKey = Key('sectorConnectedPumpsField');
  static const _notesFieldKey = Key('sectorNotesField');
  static const _mqttMsgNameFieldKey = Key('sectorMqttMsgNameField');

  Sector? _initialSector = const Sector.empty();

  Pump? _initialSectorPump = const Pump.empty();

  bool? _thisSectorHasFilter;

  bool get _isUpdating => widget.formType.isUpdating;

  /// Keeps track of various radio buttons items id
  String? _selectedSpecieId;
  String? _selectedVarietyId;
  // Keeps track of the pump that user selected to connect to the sector
  RadioButtonItem? _selectedPump;

  @override
  void initState() {
    if (_isUpdating && widget.sectorId != null) {
      final sector =
          ref.read(sectorStreamProvider(widget.sectorId!)).valueOrNull;
      final sectorPump =
          ref.read(sectorPumpStreamProvider(widget.sectorId!)).valueOrNull;
      final pump = sectorPump == null
          ? null
          : ref.read(pumpStreamProvider(sectorPump.pumpId)).valueOrNull;

      _initialSectorPump = pump;
      _initialSector = sector;

      // set the initial values for the selected pump
      _selectedPump = RadioButtonItem(
        value: pump?.id ?? '',
        label: pump?.name ?? '',
      );

      // set some form fields initial values
      _nameController.text = _initialSector?.name ?? '';
      _specieController.text = _initialSector?.specieId ?? '';
      _varietyController.text = _initialSector?.varietyId ?? '';
      _areaController.text = _initialSector?.area.toString() ?? '';
      _numOfPlantsController.text =
          _initialSector?.numOfPlants.toString() ?? '';
      _unitConsumptionController.text =
          _initialSector?.totalConsumption.toString() ?? '';
      _irrigationSystemController.text =
          _initialSector?.irrigationSystemType.uiName ?? '';
      _irrigationSourceController.text =
          _initialSector?.irrigationSource.uiName ?? '';
      _turnOnCommandController.text = _initialSector?.turnOnCommand ?? '';
      _turnOffCommandController.text = _initialSector?.turnOffCommand ?? '';
      _notesController.text = _initialSector?.notes ?? '';
      _selectedPumpController.text = pump?.name ?? '';
      _thisSectorHasFilter = _initialSector?.hasFilter;
      _mqttMsgNameController.text = _initialSector?.mqttMsgName ?? '';

      _selectedSpecieId = _initialSector?.specieId;
      _selectedVarietyId = _initialSector?.varietyId;

      // Get the varieties and pumps from the database
      if (_selectedSpecieId != null) {
        _specieController.text = ref
                .read(specieStreamProvider(_selectedSpecieId!))
                .valueOrNull
                ?.name ??
            '';
      }

      if (_selectedVarietyId != null) {
        _varietyController.text = ref
                .read(varietyStreamProvider(_selectedVarietyId!))
                .valueOrNull
                ?.name ??
            '';
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _specieController.dispose();
    _varietyController.dispose();
    _areaController.dispose();
    _numOfPlantsController.dispose();
    _unitConsumptionController.dispose();
    _irrigationSystemController.dispose();
    _irrigationSourceController.dispose();
    _turnOnCommandController.dispose();
    _turnOffCommandController.dispose();
    _notesController.dispose();
    _selectedPumpController.dispose();
    _mqttMsgNameController.dispose();
    _node.dispose();
    super.dispose();
  }

  void _onTappedSpecie() async {
    final queryParam = QueryParameters(
      id: _selectedSpecieId,
      name: specie,
    ).toJson();
    final selectedSpecie = await context.pushNamed<RadioButtonItem>(
      AppRoute.selectASpecie.name,
      queryParameters: queryParam,
    );
    if (selectedSpecie != null) {
      _specieController.text = selectedSpecie.label;
      _selectedSpecieId = selectedSpecie.value;
    }
  }

  void _onTappedVariety() async {
    final queryParam = QueryParameters(
      id: _selectedVarietyId,
      name: variety,
    ).toJson();

    final selectedVariety = await context.pushNamed<RadioButtonItem>(
      AppRoute.selectAVariety.name,
      queryParameters: queryParam,
    );

    if (selectedVariety != null) {
      _varietyController.text = selectedVariety.label;
      _selectedVarietyId = selectedVariety.value;
    }
  }

  void _onTappedIrrigationSystem() async {
    final queryParam = QueryParameters(
      id: irrigationSystem,
      name: irrigationSystem,
    ).toJson();
    final selectedIrrigationSystem = await context.pushNamed<RadioButtonItem>(
      AppRoute.selectAnIrrigationSystem.name,
      queryParameters: queryParam,
    );
    if (selectedIrrigationSystem != null) {
      _irrigationSystemController.text = selectedIrrigationSystem.label;
    }
  }

  void _onTappedIrrigationSource() async {
    final queryParam = QueryParameters(
      id: irrigationSource,
      name: irrigationSource,
    ).toJson();
    final selectedIrrigationSource = await context.pushNamed<RadioButtonItem>(
      AppRoute.selectAnIrrigationSource.name,
      queryParameters: queryParam,
    );
    if (selectedIrrigationSource != null) {
      _irrigationSourceController.text = selectedIrrigationSource.label;
    }
  }

  void _onTappedConnectedPumps() async {
    final queryParam = QueryParameters(
      id: _selectedPump?.value,
      name: _selectedPump?.label,
      previouslyConnectedId: _initialSectorPump?.id,
    ).toJson();
    final selectedPump = await context.pushNamed<RadioButtonItem>(
      AppRoute.connectPumpToSector.name,
      queryParameters: queryParam,
    );

    if (selectedPump == null) return;
    _selectedPumpController.text = selectedPump.label;
    _selectedPump = selectedPump;
  }

  void _nameEditingComplete({
    required List<String?> existingNames,
    required int maxLength,
    required String value,
    String? initialValue,
  }) {
    if (canSubmitFormNameFields(
      value: value,
      initialValue: initialValue,
      namesToCompareAgainst: existingNames,
      maxLength: maxLength,
    )) {
      _node.nextFocus();
    }
  }

  String? _nameErrorText({
    required List<String?> existingNames,
    required int maxLength,
    required String value,
    String? initialValue,
  }) {
    if (!_submitted) return null;
    final errorKey = getFormNameFieldErrorKey(
      value: value,
      maxLength: maxLength,
      namesToCompareAgainst: existingNames,
      initialValue: initialValue,
    );

    final fieldName = context.loc.nSectors(1);
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

  void _numericFieldsEditingComplete(String value) {
    if (canSubmitNumericFields(value: value)) {
      _node.nextFocus();
    }
  }

  String? _numericFieldsErrorText(String value) {
    if (!_submitted) return null;
    final errorKey = getNumericFieldsErrorKey(value: value);
    return context.getLocalizedErrorText(errorKey: errorKey);
  }

  void _canSubmitCommandFields(
    String value,
    String counterpartValue,
    String? initialValue,
    List<String?> usedCommands,
  ) {
    if (canSubmitCommandFields(
      value: value,
      counterpartValue: counterpartValue,
      initialValue: initialValue,
      valuesToCompareAgainst: usedCommands,
    )) {
      _node.nextFocus();
    }
  }

  String? _commandFieldErrorText(
    String value,
    String counterpartValue,
    String? initialValue,
    List<String?> usedCommands,
  ) {
    if (!_submitted) return null;
    final loc = context.loc;
    final singularFieldName = loc.nSectors(1);
    final pluralFieldName = loc.nSectors(2);
    final errorKey = getCommandFieldErrorKey(
      value: value,
      counterpartValue: counterpartValue,
      initialValue: initialValue,
      valuesToCompareAgainst: usedCommands,
    );
    return context.getLocalizedErrorText(
        errorKey: errorKey,
        pluralFieldName: pluralFieldName,
        fieldName: singularFieldName);
  }

  Future<bool> _checkUserIntention() async {
    final loc = context.loc;
    final userIntention = await showAlertDialog(
      context: context,
      title: loc.formGenericSaveDialogTitle,
      content: loc.formGenericSaveDialogContent(
        loc.nSectors(1),
      ),
      defaultActionText: loc.genericSaveButtonLabel,
      cancelActionText: loc.alertDialogCancel,
    );
    return userIntention ?? false;
  }

  Future<void> _submit() async {
    setState(() => _submitted = true);
    if (_formKey.currentState!.validate()) {
      final shouldSave = await _checkUserIntention();
      if (!shouldSave) return;
      final toSave = _initialSector?.copyWith(
        id: _initialSector?.id,
        name: name,
        companyId: _initialSector?.companyId,
        specieId: _selectedSpecieId,
        varietyId: _selectedVarietyId,
        area: double.tryParse(area) ?? 0.0,
        numOfPlants: double.tryParse(numOfPlants) ?? 0,
        waterConsumptionPerHour: double.tryParse(unitConsumption) ?? 0.0,
        irrigationSystemType: irrigationSystem.toIrrigationSystemType(),
        irrigationSource: irrigationSource.toIrrigationSource(),
        turnOnCommand: turnOnCommand,
        turnOffCommand: turnOffCommand,
        notes: notes,
        hasFilter: _thisSectorHasFilter,
        mqttMsgName: mqttMsgName
      );

      bool success = false;

      if (_isUpdating) {
        success = await ref
            .read(addUpdateSectorControllerProvider.notifier)
            .updateSector(
              sector: toSave,
              updatedPumpIdToConnectToSector: _selectedPump?.value,
            );
      } else {
        success = await ref
            .read(addUpdateSectorControllerProvider.notifier)
            .createSector(
              sector: toSave,
              pumpIdToConnectToSector: _selectedPump?.value,
            );
      }

      if (success) {
        _popScreen();
        return;
      }
      return;
    }
  }

  void _popScreen() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(addUpdateSectorControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));

    final numberFieldKeyboardType =
        ref.watch(numericFieldsTextInputTypeProvider);
    final state = ref.watch(addUpdateSectorControllerProvider);

    final isLoading = state.isLoading;

    final loc = context.loc;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              AppSliverBar(
                title: _isUpdating
                    ? loc.updateSectorPageTitle
                    : loc.addSectorPageTitle,
              ),
              ResponsiveSliverForm(
                node: _node,
                formKey: _formKey,
                children: [
                  FormFieldCheckboxTile(
                    title: loc.itemHasFilter,
                    value: _thisSectorHasFilter ?? false,
                    onChanged: (value) => setState(
                      () => _thisSectorHasFilter = value,
                    ),
                  ),
                  gapH16,
                  // name field
                  Consumer(
                    builder: (context, ref, child) {
                      final usedNames =
                          ref.watch(usedSectorNamesStreamProvider);
                      final value = usedNames.valueOrNull ?? [];
                      return FormTitleAndField(
                        enabled: !isLoading,
                        fieldKey: _nameFieldKey,
                        fieldTitle: loc.nameFormFieldTitle,
                        fieldHintText: loc.sectorNameHintText,
                        textInputAction: TextInputAction.next,
                        fieldController: _nameController,
                        onEditingComplete: () => _nameEditingComplete(
                          value: name,
                          maxLength: AppConstants.maxSectorNameLength,
                          existingNames: value,
                          initialValue: _initialSector?.name,
                        ),
                        validator: (_) => _nameErrorText(
                          value: name,
                          maxLength: AppConstants.maxSectorNameLength,
                          existingNames: value,
                          initialValue: _initialSector?.name,
                        ),
                      );
                    },
                  ),

                  gapH16,

                  // mqtt msg name field
                  Consumer(
                    builder: (context, ref, child) {
                      final usedMqttNames =
                          ref.watch(sectorUsedMqttMessageNamesStreamProvider);
                      final value = usedMqttNames.valueOrNull ?? [];
                      return FormTitleAndField(
                        enabled: !isLoading,
                        fieldKey: _mqttMsgNameFieldKey,
                        fieldController: _mqttMsgNameController,
                        fieldTitle: loc.mqttMessageNameFormFieldTitle,
                        fieldHintText: loc.mqttMessageNameFormHint,
                        textInputAction: TextInputAction.next,
                        validator: (_) => _nameErrorText(
                          existingNames: value,
                          maxLength: AppConstants.maxMqttMessageNameLength,
                          value: mqttMsgName,
                          initialValue: _initialSector?.mqttMsgName,
                        ),
                        onEditingComplete: () => _nameEditingComplete(
                          existingNames: value,
                          maxLength: AppConstants.maxMqttMessageNameLength,
                          value: mqttMsgName,
                          initialValue: _initialSector?.mqttMsgName,
                        ),
                      );
                    },
                  ),

                  gapH16,
                  // specie field
                  FormTitleAndField(
                    enabled: !isLoading,
                    fieldKey: _specieFieldKey,
                    fieldTitle: loc.sectorSpecie,
                    fieldHintText: loc.sectorSpecieHintText,
                    canRequestFocus: false,
                    keyboardType: TextInputType.none,
                    onTap: _onTappedSpecie,
                    suffixIcon:
                        CommonFormSuffixIcon(onPressed: _onTappedSpecie),
                    fieldController: _specieController,
                    onEditingComplete: () =>
                        _nonEmptyFieldsEditingComplete(specie),
                    validator: (_) => _nonEmptyFieldsErrorText(specie),
                  ),
                  gapH16,
                  // variety field
                  FormTitleAndField(
                    enabled: !isLoading,
                    fieldKey: _varietyFieldKey,
                    fieldTitle: loc.sectorVariety,
                    fieldHintText: loc.sectorVarietyHintText,
                    textInputAction: TextInputAction.none,
                    canRequestFocus: false,
                    fieldController: _varietyController,
                    onTap: _onTappedVariety,
                    suffixIcon: CommonFormSuffixIcon(
                      onPressed: _onTappedVariety,
                    ),
                    onEditingComplete: () =>
                        _nonEmptyFieldsEditingComplete(variety),
                    validator: (_) => _nonEmptyFieldsErrorText(variety),
                  ),
                  gapH16,
                  // occupied area field
                  FormTitleAndField(
                    enabled: !isLoading,
                    fieldKey: _areaFieldKey,
                    fieldTitle: loc.sectorOccupiedArea,
                    fieldHintText: loc.sectorOccupiedAreaHintText,
                    textInputAction: TextInputAction.next,
                    fieldController: _areaController,
                    onEditingComplete: () =>
                        _numericFieldsEditingComplete(area),
                    validator: (_) => _numericFieldsErrorText(area),
                    keyboardType: numberFieldKeyboardType,
                  ),
                  gapH16,
                  // number of plants field
                  FormTitleAndField(
                    enabled: !isLoading,
                    fieldKey: _numOfPlantsFieldKey,
                    fieldTitle: loc.sectorNumberOfPlants,
                    fieldHintText: loc.sectorNumberOfPlantsHintText,
                    textInputAction: TextInputAction.next,
                    fieldController: _numOfPlantsController,
                    onEditingComplete: () =>
                        _numericFieldsEditingComplete(numOfPlants),
                    validator: (_) => _numericFieldsErrorText(numOfPlants),
                    keyboardType: numberFieldKeyboardType,
                  ),
                  gapH16,
                  // unit consumption per hour by plant field
                  FormTitleAndField(
                    enabled: !isLoading,
                    fieldKey: _unitConsumptionFieldKey,
                    fieldTitle: loc.sectorUnitConsumptionPerHour,
                    fieldHintText: loc.sectorUnitConsumptionPerHourHintText,
                    textInputAction: TextInputAction.next,
                    fieldController: _unitConsumptionController,
                    onEditingComplete: () =>
                        _numericFieldsEditingComplete(unitConsumption),
                    validator: (_) => _numericFieldsErrorText(unitConsumption),
                    keyboardType: numberFieldKeyboardType,
                  ),
                  gapH16,

                  // irrigation system field
                  FormTitleAndField(
                    enabled: !isLoading,
                    fieldKey: _irrigationSystemFieldKey,
                    fieldController: _irrigationSystemController,
                    fieldTitle: loc.sectorIrrigationSystem,
                    fieldHintText: loc.selectAnOptionHintText,
                    canRequestFocus: false,
                    keyboardType: TextInputType.none,
                    onTap: _onTappedIrrigationSystem,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.arrow_drop_down),
                      onPressed: _onTappedIrrigationSystem,
                    ),
                    onEditingComplete: () =>
                        _nonEmptyFieldsEditingComplete(irrigationSystem),
                    validator: (_) =>
                        _nonEmptyFieldsErrorText(irrigationSystem),
                  ),

                  gapH16,
                  // source of irrigation field
                  FormTitleAndField(
                    enabled: !isLoading,
                    fieldKey: _irrigationSourceFieldKey,
                    fieldController: _irrigationSourceController,
                    fieldTitle: loc.sectorIrrigationSource,
                    fieldHintText: loc.selectAnOptionHintText,
                    canRequestFocus: false,
                    keyboardType: TextInputType.none,
                    onTap: _onTappedIrrigationSource,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.arrow_drop_down),
                      onPressed: _onTappedIrrigationSource,
                    ),
                    onEditingComplete: () =>
                        _nonEmptyFieldsEditingComplete(irrigationSource),
                    validator: (_) =>
                        _nonEmptyFieldsErrorText(irrigationSource),
                  ),
                  gapH16,
                  // mqtt command to turn on sector field
                  Consumer(
                    builder: (context, ref, child) {
                      final usedCommands =
                          ref.watch(usedSectorCommandsStreamProvider);
                      final commands = usedCommands.valueOrNull ?? [];
                      return FormTitleAndField(
                        enabled: !isLoading,
                        fieldKey: _turnOnCommandFieldKey,
                        fieldTitle: loc.onCommandFormFieldTitle,
                        fieldHintText: loc.onCommandFormHint,
                        textInputAction: TextInputAction.next,
                        keyboardType: numberFieldKeyboardType,
                        fieldController: _turnOnCommandController,
                        onEditingComplete: () => _canSubmitCommandFields(
                          turnOnCommand,
                          turnOffCommand,
                          _initialSector?.turnOnCommand,
                          commands,
                        ),
                        validator: (_) => _commandFieldErrorText(
                          turnOnCommand,
                          turnOffCommand,
                          _initialSector?.turnOnCommand,
                          commands,
                        ),
                      );
                    },
                  ),

                  gapH16,
                  // mqtt command to turn off sector field
                  Consumer(
                    builder: (context, ref, child) {
                      final usedCommands =
                          ref.watch(usedSectorCommandsStreamProvider);
                      final commands = usedCommands.valueOrNull ?? [];
                      return FormTitleAndField(
                        enabled: !isLoading,
                        fieldKey: _turnOffCommandFieldKey,
                        fieldTitle: loc.offCommandFormFieldTitle,
                        fieldHintText: loc.offCommandFormHint,
                        keyboardType: numberFieldKeyboardType,
                        textInputAction: TextInputAction.next,
                        fieldController: _turnOffCommandController,
                        onEditingComplete: () => _canSubmitCommandFields(
                          turnOffCommand,
                          turnOnCommand,
                          _initialSector?.turnOffCommand,
                          commands,
                        ),
                        validator: (_) => _commandFieldErrorText(
                          turnOffCommand,
                          turnOnCommand,
                          _initialSector?.turnOffCommand,
                          commands,
                        ),
                      );
                    },
                  ),
                  gapH16,
                  // connected pump field
                  FormTitleAndField(
                    enabled: !isLoading,
                    fieldController: _selectedPumpController,
                    fieldKey: _connectedPumpsFieldKey,
                    fieldTitle: loc.sectorConnectedPumps,
                    fieldHintText: loc.selectAPumpHintText,
                    canRequestFocus: false,
                    keyboardType: TextInputType.none,
                    validator: (_) => _nonEmptyFieldsErrorText(selectedPump),
                    onEditingComplete: () =>
                        _nonEmptyFieldsEditingComplete(selectedPump),
                    onTap: _onTappedConnectedPumps,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.arrow_drop_down),
                      onPressed: _onTappedConnectedPumps,
                    ),
                  ),

                  gapH16,
                  // notes field
                  FormTitleAndField(
                    enabled: !isLoading,
                    fieldKey: _notesFieldKey,
                    fieldTitle: loc.sectorNotes,
                    textInputAction: TextInputAction.done,
                    maxLines: 3,
                    fieldController: _notesController,
                  ),
                  gapH16,
                ],
              )
            ],
          ),
        ),
        gapH16,
        // button to save or update the sector
        SliverCTAButton(
          isLoading: isLoading,
          text: _isUpdating
              ? loc.genericUpdateButtonLabel
              : loc.genericSaveButtonLabel,
          buttonType: ButtonType.primary,
          onPressed: _submit,
        ),
        gapH32,
      ],
    );
  }
}
