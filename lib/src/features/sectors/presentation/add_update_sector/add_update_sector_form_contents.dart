import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/enums/button_types.dart';
import 'package:irrigazione_iot/src/config/enums/form_types.dart';
import 'package:irrigazione_iot/src/config/enums/irrigation_enums.dart';
import 'package:irrigazione_iot/src/config/routes/app_router.dart';
import 'package:irrigazione_iot/src/constants/app_constants.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/domain/sector.dart';
import 'package:irrigazione_iot/src/features/sectors/presentation/add_update_sector/add_update_sector_controller.dart';
import 'package:irrigazione_iot/src/features/sectors/presentation/add_update_sector/add_update_sector_form_validator.dart';
import 'package:irrigazione_iot/src/utils/app_form_error_texts_extension.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/utils/numeric_fields_text_type.dart';
import 'package:irrigazione_iot/src/widgets/alert_dialogs.dart';
import 'package:irrigazione_iot/src/widgets/app_cta_button.dart';
import 'package:irrigazione_iot/src/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/widgets/form_title_and_field.dart';
import 'package:irrigazione_iot/src/widgets/responsive_sliver_form.dart';

class AddUpdateSectorFormContents extends ConsumerStatefulWidget {
  const AddUpdateSectorFormContents(
      {super.key, required this.formType, this.sectorId});

  final SectorID? sectorId;
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
  // TODO add connected pump field

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
  static const _notesFieldKey = Key('sectorNotesField');

  Sector? _initialSector = const Sector.empty();

  @override
  void initState() {
    if (widget.formType.isUpdating() && widget.sectorId != null) {
      final sector =
          ref.read(sectorStreamProvider(widget.sectorId!)).valueOrNull;
      _initialSector = sector;
      _nameController.text = _initialSector?.name ?? '';
      _specieController.text = _initialSector?.availableSpecie ?? '';
      _varietyController.text = _initialSector?.specieVariety ?? '';
      _areaController.text = _initialSector?.area.toString() ?? '';
      _numOfPlantsController.text =
          _initialSector?.numOfPlants.toString() ?? '';
      _unitConsumptionController.text =
          _initialSector?.waterConsumptionPerHourByPlant.toString() ?? '';
      _irrigationSystemController.text =
          _initialSector?.irrigationSystemType.uiName ?? '';
      _irrigationSourceController.text =
          _initialSector?.irrigationSource.uiName ?? '';
      _turnOnCommandController.text = _initialSector?.turnOnCommand ?? '';
      _turnOffCommandController.text = _initialSector?.turnOffCommand ?? '';
      _notesController.text = _initialSector?.notes ?? '';
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

  // todo complete implementation
  void _nameEditingComplete() {
    if (canSubmitNameField(name, null, ['sector'])) {
      _node.nextFocus();
    }
  }

  // todo complete implementation
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

  // todo complete implementation
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

  // todo complete implementation
  String? _commandFieldErrorText(
    String value,
    String counterpartValue,
    String? initialValue,
    List<String?> usedCommands,
  ) {
    if (!_submitted) return null;
    final singularFieldName = context.loc.nSectors(1);
    final pluralFieldName = context.loc.nSectors(2);
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
    final userIntention = await showAlertDialog(
      context: context,
      title: context.loc.formGenericSaveDialogTitle,
      content: context.loc.formGenericSaveDialogContent(
        context.loc.nSectors(1),
      ),
      defaultActionText: context.loc.genericSaveButtonLabel,
      cancelActionText: context.loc.alertDialogCancel,
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
        availableSpecie: specie,
        specieVariety: variety,
        area: double.tryParse(area) ?? 0.0,
        numOfPlants: int.tryParse(numOfPlants) ?? 0,
        waterConsumptionPerHourByPlant: double.tryParse(unitConsumption) ?? 0.0,
        irrigationSystemType: irrigationSystem.toIrrigationSystemType(),
        irrigationSource: irrigationSource.toIrrigationSource(),
        turnOnCommand: turnOnCommand,
        turnOffCommand: turnOffCommand,
        notes: notes,
      );

      if (toSave == _initialSector && widget.formType.isUpdating()) {
        debugPrint('No changes detected, not submitting...');
        _popScreen();
        return;
      }
      if (toSave == null) {
        debugPrint(
            'Form is valid but there are no data to save, not submitting...');
        _popScreen();
        return;
      }

      bool success = false;

      if (widget.formType.isUpdating()) {
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
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final numberFieldKeyboardType =
        ref.watch(numericFieldsTextInputTypeProvider);
    final isUpdating = widget.formType.isUpdating();

    // already used values for form validation
    final usedSectorNames =
        ref.watch(usedSectorNamesStreamProvider).valueOrNull;
    final usedSectorOnCommands =
        ref.watch(usedSectorOnCommandsStreamProvider).valueOrNull;
    final usedSectorOffCommands =
        ref.watch(usedSectorOffCommandsStreamProvider).valueOrNull;

    final state = ref.watch(addUpdateSectorControllerProvider);

    final isLoading = state.isLoading;
    return CustomScrollView(
      slivers: [
        AppSliverBar(
          title: isUpdating
              ? context.loc.updateSectorPageTitle
              : context.loc.addSectorPageTitle,
        ),
        ResponsiveSliverForm(
          node: _node,
          formKey: _formKey,
          children: [
            // name field
            FormTitleAndField(
              enabled: !isLoading,
              fieldKey: _nameFieldKey,
              fieldTitle: context.loc.sectorName,
              fieldHintText: context.loc.sectorNameHintText,
              textInputAction: TextInputAction.next,
              fieldController: _nameController,
              onEditingComplete: _nameEditingComplete,
              validator: (_) => _nameErrorText(usedSectorNames ?? []),
            ),
            gapH16,
            // specie field
            FormTitleAndField(
              enabled: !isLoading,
              fieldKey: _specieFieldKey,
              fieldTitle: context.loc.sectorSpecie,
              fieldHintText: context.loc.sectorSpecieHintText,
              canRequestFocus: false,
              keyboardType: TextInputType.none,
              onTap: _onTappedSpecie,
              suffixIcon: IconButton(
                icon: const Icon(Icons.arrow_drop_down),
                onPressed: _onTappedSpecie,
              ),
              fieldController: _specieController,
              onEditingComplete: () => _nonEmptyFieldsEditingComplete(specie),
              validator: (_) => _nonEmptyFieldsErrorText(specie),
            ),
            gapH16,
            // variety field
            FormTitleAndField(
              enabled: !isLoading,
              fieldKey: _varietyFieldKey,
              fieldTitle: context.loc.sectorVariety,
              fieldHintText: context.loc.sectorVarietyHintText,
              textInputAction: TextInputAction.next,
              fieldController: _varietyController,
              onEditingComplete: () => _nonEmptyFieldsEditingComplete(variety),
              validator: (_) => _nonEmptyFieldsErrorText(variety),
            ),
            gapH16,
            // occupied area field
            FormTitleAndField(
              enabled: !isLoading,
              fieldKey: _areaFieldKey,
              fieldTitle: context.loc.sectorOccupiedArea,
              fieldHintText: context.loc.sectorOccupiedAreaHintText,
              textInputAction: TextInputAction.next,
              fieldController: _areaController,
              onEditingComplete: () => _numericFieldsEditingComplete(area),
              validator: (_) => _numericFieldsErrorText(area),
              keyboardType: numberFieldKeyboardType,
            ),
            gapH16,
            // number of plants field
            FormTitleAndField(
              enabled: !isLoading,
              fieldKey: _numOfPlantsFieldKey,
              fieldTitle: context.loc.sectorNumberOfPlants,
              fieldHintText: context.loc.sectorNumberOfPlantsHintText,
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
              fieldTitle: context.loc.sectorUnitConsumptionPerHour,
              fieldHintText: context.loc.sectorUnitConsumptionPerHourHintText,
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
              fieldTitle: context.loc.sectorIrrigationSystem,
              fieldHintText: context.loc.sectorIrrigationSystemHintText,
              canRequestFocus: false,
              keyboardType: TextInputType.none,
              onTap:
                  _onTappedIrrigationSystem, // todo replace with the right function
              suffixIcon: IconButton(
                icon: const Icon(Icons.arrow_drop_down),
                onPressed: _onTappedIrrigationSystem,
              ),
              onEditingComplete: () =>
                  _nonEmptyFieldsEditingComplete(irrigationSystem),
              validator: (_) => _nonEmptyFieldsErrorText(irrigationSystem),
            ),

            gapH16,
            // source of irrigation field
            FormTitleAndField(
              enabled: !isLoading,
              fieldKey: _irrigationSourceFieldKey,
              fieldController: _irrigationSourceController,
              fieldTitle: context.loc.sectorIrrigationSource,
              fieldHintText: context.loc.sectorIrrigationSourceHintText,
              canRequestFocus: false,
              keyboardType: TextInputType.none,
              onTap:
                  _onTappedIrrigationSource, // todo replace with the right function
              suffixIcon: IconButton(
                icon: const Icon(Icons.arrow_drop_down),
                onPressed: _onTappedIrrigationSource,
              ),
              onEditingComplete: () =>
                  _nonEmptyFieldsEditingComplete(irrigationSource),
              validator: (_) => _nonEmptyFieldsErrorText(irrigationSource),
            ),
            gapH16,
            // mqtt command to turn on sector field
            FormTitleAndField(
                enabled: !isLoading,
                fieldKey: _turnOnCommandFieldKey,
                fieldTitle: context.loc.sectorOnCommand,
                fieldHintText: context.loc.sectorOnCommandHintText,
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
                fieldTitle: context.loc.sectorOffCommand,
                fieldHintText: context.loc.sectorOffCommandHintText,
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
            // notes field
            FormTitleAndField(
              enabled: !isLoading,
              fieldKey: _notesFieldKey,
              fieldTitle: context.loc.sectorNotes,
              textInputAction: TextInputAction.done,
              maxLines: 3,
              fieldController: _notesController,
            ),
            gapH16,

            // button to save or update the sector
            CTAButton(
              isLoading: isLoading,
              text: isUpdating
                  ? context.loc.genericUpdateButtonLabel
                  : context.loc.genericSaveButtonLabel,
              buttonType: ButtonType.primary,
              onPressed: _submit,
            ),
            gapH32
          ],
        )
      ],
    );
  }
}
