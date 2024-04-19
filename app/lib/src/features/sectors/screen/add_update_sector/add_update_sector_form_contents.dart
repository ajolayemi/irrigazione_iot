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
import 'package:irrigazione_iot/src/features/sectors/data/sector_pump_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector_pump.dart';
import 'package:irrigazione_iot/src/features/sectors/screen/add_update_sector/add_update_sector_controller.dart';
import 'package:irrigazione_iot/src/features/sectors/screen/add_update_sector/add_update_sector_form_validator.dart';
import 'package:irrigazione_iot/src/shared/models/radio_button_return_type.dart';
import 'package:irrigazione_iot/src/utils/app_form_error_texts_extension.dart';
import 'package:irrigazione_iot/src/utils/async_value_ui.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/utils/numeric_fields_text_type.dart';
import 'package:irrigazione_iot/src/shared/widgets/alert_dialogs.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_cta_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/shared/widgets/form_title_and_field.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_sliver_form.dart';

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
    extends ConsumerState<AddUpdateSectorFormContents>
    with AddUpdateSectorValidators {
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

  Sector? _initialSector = const Sector.empty();

  SectorPump? _initialSectorPump = const SectorPump.empty();

  bool get _isUpdating => widget.formType.isUpdating;

  @override
  void initState() {
    if (widget.formType.isUpdating && widget.sectorId != null) {
      final sector =
          ref.read(sectorStreamProvider(widget.sectorId!)).valueOrNull;
      final sectorPump =
          ref.read(sectorPumpStreamProvider(widget.sectorId!)).valueOrNull;
      final pump = sectorPump == null
          ? null
          : ref.read(pumpStreamProvider(sectorPump.pumpId)).valueOrNull;
      _initialSectorPump = sectorPump;
      _initialSector = sector;
      _nameController.text = _initialSector?.name ?? '';
      // TODO: specie and variety names should be displayed in the form not their ids
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
    _node.dispose();
    super.dispose();
  }

  void _onTappedSpecie() async {
    final selectedSpecie = await context.pushNamed(AppRoute.selectASpecie.name);
    if (selectedSpecie != null) {
      _specieController.text = selectedSpecie.toString();
    }
  }

  void _onTappedIrrigationSystem() async {
    final selectedIrrigationSystem =
        await context.pushNamed(AppRoute.selectAnIrrigationSystem.name);
    if (selectedIrrigationSystem != null) {
      _irrigationSystemController.text = selectedIrrigationSystem.toString();
    }
  }

  void _onTappedIrrigationSource() async {
    final selectedIrrigationSource =
        await context.pushNamed(AppRoute.selectAnIrrigationSource.name);
    if (selectedIrrigationSource != null) {
      _irrigationSourceController.text = selectedIrrigationSource.toString();
    }
  }

  void _onTappedConnectedPumps() async {
    final selectedPump = await context.pushNamed<RadioButtonReturnType>(
        AppRoute.connectPumpToSector.name,
        queryParameters: {
          'pumpIdAlreadyConnected': _initialSectorPump?.pumpId ?? '',
        });

    if (selectedPump == null) return;
    _selectedPumpController.text = selectedPump.label;
  }

  void _nameEditingComplete(List<String?> usedSectorNames) {
    if (canSubmitNameField(name, _initialSector?.name, usedSectorNames)) {
      _node.nextFocus();
    }
  }

  String? _nameErrorText(List<String?> usedSectorNames) {
    if (!_submitted) return null;
    final errorKey =
        sectorNameErrorText(name, _initialSector?.name, usedSectorNames);
    final fieldName = context.loc.nSectors(1);
    return context.getLocalizedErrorText(
      errorKey: errorKey,
      fieldName: fieldName,
      maxFieldLength: AppConstants.maxSectorNameLength,
    );
  }

  void _nonEmptyFieldsEditingComplete(String value) {
    if (canSubmitNonEmptyFields(value)) {
      _node.nextFocus();
    }
  }

  String? _nonEmptyFieldsErrorText(String value) {
    if (!_submitted) return null;
    final errorKey = nonEmptyFieldsErrorText(value);
    return context.getLocalizedErrorText(errorKey: errorKey);
  }

  void _numericFieldsEditingComplete(String value) {
    if (canSubmitNumericFields(value)) {
      _node.nextFocus();
    }
  }

  String? _numericFieldsErrorText(String value) {
    if (!_submitted) return null;
    final errorKey = numericFieldsErrorText(value);
    return context.getLocalizedErrorText(errorKey: errorKey);
  }

  void _canSubmitCommandFields(
    String value,
    String counterpartValue,
    String? initialValue,
    List<String?> usedCommands,
  ) {
    if (canSubmitCommandFields(
        value, counterpartValue, initialValue, usedCommands)) {
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
    final errorKey = commandFieldsErrorText(
      value,
      counterpartValue,
      initialValue,
      usedCommands,
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
        specieId: specie,
        varietyId: variety,
        area: double.tryParse(area) ?? 0.0,
        numOfPlants: double.tryParse(numOfPlants) ?? 0,
        waterConsumptionPerHour: double.tryParse(unitConsumption) ?? 0.0,
        irrigationSystemType: irrigationSystem.toIrrigationSystemType(),
        irrigationSource: irrigationSource.toIrrigationSource(),
        turnOnCommand: turnOnCommand,
        turnOffCommand: turnOffCommand,
        notes: notes,
      );

      bool success = false;

      if (widget.formType.isUpdating) {
        success = await ref
            .read(addUpdateSectorControllerProvider.notifier)
            .updateSector(toSave);
      } else {
        success = await ref
            .read(addUpdateSectorControllerProvider.notifier)
            .createSector(toSave);
      }

      if (success) {
        _popScreen();
        return;
      }
      return;
    }
  }

  void _popScreen() {
    ref.read(selectPumpRadioButtonProvider.notifier).state = null;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(addUpdateSectorControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    final numberFieldKeyboardType =
        ref.watch(numericFieldsTextInputTypeProvider);
    final isUpdating = widget.formType.isUpdating;

    // already used values for form validation
    final usedSectorNames =
        ref.watch(usedSectorNamesStreamProvider).valueOrNull;
    final usedSectorOnCommands =
        ref.watch(usedSectorOnCommandsStreamProvider).valueOrNull;
    final usedSectorOffCommands =
        ref.watch(usedSectorOffCommandsStreamProvider).valueOrNull;

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
                title: isUpdating
                    ? loc.updateSectorPageTitle
                    : loc.addSectorPageTitle,
              ),
              ResponsiveSliverForm(
                node: _node,
                formKey: _formKey,
                children: [
                  // name field
                  FormTitleAndField(
                    enabled: !isLoading,
                    fieldKey: _nameFieldKey,
                    fieldTitle: loc.sectorName,
                    fieldHintText: loc.sectorNameHintText,
                    textInputAction: TextInputAction.next,
                    fieldController: _nameController,
                    onEditingComplete: () =>
                        _nameEditingComplete(usedSectorNames ?? []),
                    validator: (_) => _nameErrorText(usedSectorNames ?? []),
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
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.arrow_drop_down),
                      onPressed: _onTappedSpecie,
                    ),
                    fieldController: _specieController,
                    onEditingComplete: () =>
                        _nonEmptyFieldsEditingComplete(specie),
                    validator: (_) => _nonEmptyFieldsErrorText(specie),
                  ),
                  gapH16,
                  // variety field
                  // TODO: should be dropdown just like specie
                  FormTitleAndField(
                    enabled: !isLoading,
                    fieldKey: _varietyFieldKey,
                    fieldTitle: loc.sectorVariety,
                    fieldHintText: loc.sectorVarietyHintText,
                    textInputAction: TextInputAction.next,
                    fieldController: _varietyController,
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
                    fieldHintText: loc.sectorIrrigationSystemHintText,
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
                    fieldHintText: loc.sectorIrrigationSourceHintText,
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
                  FormTitleAndField(
                      enabled: !isLoading,
                      fieldKey: _turnOnCommandFieldKey,
                      fieldTitle: loc.sectorOnCommand,
                      fieldHintText: loc.sectorOnCommandHintText,
                      textInputAction: TextInputAction.next,
                      keyboardType: numberFieldKeyboardType,
                      fieldController: _turnOnCommandController,
                      onEditingComplete: () => _canSubmitCommandFields(
                            turnOnCommand,
                            turnOffCommand,
                            _initialSector?.turnOnCommand,
                            usedSectorOnCommands ?? [],
                          ),
                      validator: (_) => _commandFieldErrorText(
                          turnOnCommand,
                          turnOffCommand,
                          _initialSector?.turnOnCommand,
                          usedSectorOnCommands ?? [])),
                  gapH16,
                  // mqtt command to turn off sector field
                  FormTitleAndField(
                      enabled: !isLoading,
                      fieldKey: _turnOffCommandFieldKey,
                      fieldTitle: loc.sectorOffCommand,
                      fieldHintText: loc.sectorOffCommandHintText,
                      keyboardType: numberFieldKeyboardType,
                      textInputAction: TextInputAction.next,
                      fieldController: _turnOffCommandController,
                      onEditingComplete: () => _canSubmitCommandFields(
                            turnOffCommand,
                            turnOnCommand,
                            _initialSector?.turnOffCommand,
                            usedSectorOffCommands ?? [],
                          ),
                      validator: (_) => _commandFieldErrorText(
                          turnOffCommand,
                          turnOnCommand,
                          _initialSector?.turnOffCommand,
                          usedSectorOffCommands ?? [])),
                  gapH16,

                  // TODO display selected pump name
                  // connected pump field
                  FormTitleAndField(
                    enabled: !isLoading,
                    fieldController: _selectedPumpController,
                    fieldKey: _connectedPumpsFieldKey,
                    fieldTitle: loc.sectorConnectedPumps,
                    fieldHintText: loc.selectAPump,
                    canRequestFocus: false,
                    keyboardType: TextInputType.none,
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
          text: isUpdating
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
