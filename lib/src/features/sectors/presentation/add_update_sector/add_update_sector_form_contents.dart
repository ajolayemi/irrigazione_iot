import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/enums/button_types.dart';
import 'package:irrigazione_iot/src/config/enums/form_types.dart';
import 'package:irrigazione_iot/src/config/routes/app_router.dart';
import 'package:irrigazione_iot/src/constants/app_constants.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/sectors/domain/sector.dart';
import 'package:irrigazione_iot/src/features/sectors/presentation/add_update_sector/add_update_sector_form_validator.dart';
import 'package:irrigazione_iot/src/utils/app_form_error_texts_extension.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/utils/numeric_fields_text_type.dart';
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

  Future<void> _submitForm() async {
    setState(() => _submitted = true);
    if (_formKey.currentState!.validate()) {
      debugPrint('Sector Form is valid');
    }
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
  String? _nameErrorText() {
    if (!_submitted) return null;
    final errorKey = sectorNameErrorText(name, null, ['sector']);
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
  void _canSubmitCommandFields(String value, String counterpartValue) {
    if (canSubmitCommandFields(value, counterpartValue, null, ['1'])) {
      _node.nextFocus();
    }
  }

  // todo complete implementation
  String? _commandFieldErrorText(String value, String counterpartValue) {
    if (!_submitted) return null;
    final singularFieldName = context.loc.nSectors(1);
    final pluralFieldName = context.loc.nSectors(2);
    final errorKey =
        commandFieldsErrorText(value, counterpartValue, null, ['1']);
    return context.getLocalizedErrorText(
      errorKey: errorKey,
      pluralFieldName: pluralFieldName,
      fieldName: singularFieldName
    );
  }

  @override
  Widget build(BuildContext context) {
    final numberFieldKeyboardType =
        ref.watch(numericFieldsTextInputTypeProvider);
    final isUpdating = widget.formType.isUpdating();

    const state = true; // todo replace with the right state
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
              enabled: state,
              fieldKey: _nameFieldKey,
              fieldTitle: context.loc.sectorName,
              fieldHintText: context.loc.sectorNameHintText,
              textInputAction: TextInputAction.next,
              fieldController: _nameController,
              onEditingComplete: _nameEditingComplete,
              validator: (_) => _nameErrorText(),
            ),
            gapH16,
            // specie field
            FormTitleAndField(
              enabled: state,
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
              onEditingComplete: () =>  _nonEmptyFieldsEditingComplete(specie),
              validator: (_) => _nonEmptyFieldsErrorText(specie),
            ),
            gapH16,
            // variety field
            FormTitleAndField(
              enabled: state,
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
              enabled: state,
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
              enabled: state,
              fieldKey: _numOfPlantsFieldKey,
              fieldTitle: context.loc.sectorNumberOfPlants,
              fieldHintText: context.loc.sectorNumberOfPlantsHintText,
              textInputAction: TextInputAction.next,
              fieldController: _numOfPlantsController,
              onEditingComplete: () => _numericFieldsEditingComplete(numOfPlants),
              validator: (_) => _numericFieldsErrorText(numOfPlants),
              keyboardType: numberFieldKeyboardType,
            ),
            gapH16,
            // unit consumption per hour by plant field
            FormTitleAndField(
              enabled: state,
              fieldKey: _unitConsumptionFieldKey,
              fieldTitle: context.loc.sectorUnitConsumptionPerHour,
              fieldHintText: context.loc.sectorUnitConsumptionPerHourHintText,
              textInputAction: TextInputAction.next,
              fieldController: _unitConsumptionController,
              onEditingComplete: () => _numericFieldsEditingComplete(unitConsumption),
              validator: (_) => _numericFieldsErrorText(unitConsumption),
              keyboardType: numberFieldKeyboardType,
            ),
            gapH16,

            // irrigation system field
            FormTitleAndField(
              enabled: state,
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
              onEditingComplete: () => _nonEmptyFieldsEditingComplete(irrigationSystem),
              validator: (_) => _nonEmptyFieldsErrorText(irrigationSystem),
            ),

            gapH16,
            // source of irrigation field
            FormTitleAndField(
              enabled: state,
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
              onEditingComplete: () => _nonEmptyFieldsEditingComplete(irrigationSource),
              validator: (_) => _nonEmptyFieldsErrorText(irrigationSource),
            ),
            gapH16,
            // mqtt command to turn on sector field
            FormTitleAndField(
              enabled: state,
              fieldKey: _turnOnCommandFieldKey,
              fieldTitle: context.loc.sectorOnCommand,
              fieldHintText: context.loc.sectorOnCommandHintText,
              textInputAction: TextInputAction.next,
              keyboardType: numberFieldKeyboardType,
              fieldController: _turnOnCommandController,
              onEditingComplete: () => _canSubmitCommandFields(turnOnCommand, turnOffCommand),
              validator: (_) => _commandFieldErrorText(turnOnCommand, turnOffCommand)
            ),
            gapH16,
            // mqtt command to turn off sector field
            FormTitleAndField(
              enabled: state,
              fieldKey: _turnOffCommandFieldKey,
              fieldTitle: context.loc.sectorOffCommand,
              fieldHintText: context.loc.sectorOffCommandHintText,
              keyboardType: numberFieldKeyboardType,
              textInputAction: TextInputAction.next,
              fieldController: _turnOffCommandController,
              onEditingComplete: () => _canSubmitCommandFields(turnOffCommand, turnOnCommand),
              validator: (_) => _commandFieldErrorText(turnOffCommand, turnOnCommand)
            ),
            gapH16,
            // notes field
            FormTitleAndField(
              enabled: state,
              fieldKey: _notesFieldKey,
              fieldTitle: context.loc.sectorNotes,
              textInputAction: TextInputAction.done,
              maxLines: 3,
              fieldController: _notesController,
            ),
            gapH16,

            // button to save or update the sector
            CTAButton(
              isLoading: !state,
              text: isUpdating
                  ? context.loc.genericUpdateButtonLabel
                  : context.loc.genericSaveButtonLabel,
              buttonType: ButtonType.primary,
              onPressed: _submitForm,
            ),
            gapH32
          ],
        )
      ],
    );
  }
}
