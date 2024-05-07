import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:irrigazione_iot/src/config/enums/button_types.dart';
import 'package:irrigazione_iot/src/config/enums/form_types.dart';
import 'package:irrigazione_iot/src/constants/app_constants.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';
import 'package:irrigazione_iot/src/features/pumps/screen/add_pump/add_update_pump_controller.dart';
import 'package:irrigazione_iot/src/shared/widgets/alert_dialogs.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_cta_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/shared/widgets/form_field_checkbox.dart';
import 'package:irrigazione_iot/src/shared/widgets/form_title_and_field.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_scrollable.dart';
import 'package:irrigazione_iot/src/utils/app_form_error_texts_extension.dart';
import 'package:irrigazione_iot/src/utils/app_form_validators.dart';
import 'package:irrigazione_iot/src/utils/extensions/extensions.dart';
import 'package:irrigazione_iot/src/utils/numeric_fields_text_type.dart';

class AddUpdatePumpContents extends ConsumerStatefulWidget {
  const AddUpdatePumpContents({
    super.key,
    required this.formType,
    this.pumpId,
  });

  final GenericFormTypes formType;
  final String? pumpId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddUpdatePumpContents();
}

class _AddUpdatePumpContents extends ConsumerState<AddUpdatePumpContents>
    with AppFormValidators {
  final _formKey = GlobalKey<FormState>();

  // form fields controllers
  final _nameController = TextEditingController();
  final _volumeCapacityController = TextEditingController();
  final _mqttMessageNameController = TextEditingController();
  final _kwCapacityController = TextEditingController();
  final _onCommandController = TextEditingController();
  final _offCommandController = TextEditingController();

  final _node = FocusScopeNode();

  // get methods to access form field values
  String get name => _nameController.text;
  String get volumeCapacity => _volumeCapacityController.text;
  String get kwCapacity => _kwCapacityController.text;
  String get onCommand => _onCommandController.text;
  String get offCommand => _offCommandController.text;
  String get mqttMessageName => _mqttMessageNameController.text;

  // local variable used to apply AutovalidateMode.onUserInteraction and show
  // error hints only when the form has been submitted
  // For more details on how this is implemented, see:
  // https://codewithandrea.com/articles/flutter-text-field-form-validation/
  var _submitted = false;

  Pump? _initialPump = const Pump.empty();

  bool _thisPumpHasFilter = false;

  static const _nameFieldKey = Key('name');
  static const _volumeCapacityFieldKey = Key('volumeCapacity');
  static const _kwCapacityFieldKey = Key('kwCapacity');
  static const _onCommandFieldKey = Key('onCommand');
  static const _offCommandFieldKey = Key('offCommand');
  static const _mqttMessageNameFieldKey = Key('mqttMessageName');

  bool get _isUpdating => widget.formType.isUpdating;

  @override
  void initState() {
    if (_isUpdating && widget.pumpId != null) {
      final pump = ref.read(pumpStreamProvider(widget.pumpId!)).valueOrNull;
      _initialPump = pump;
      _thisPumpHasFilter = pump?.hasFilter ?? false;
      _nameController.text = pump?.name ?? '';
      _volumeCapacityController.text = pump?.capacityInVolume.toString() ?? '';
      _kwCapacityController.text = pump?.consumeRateInKw.toString() ?? '';
      _onCommandController.text = pump?.turnOnCommand ?? '';
      _offCommandController.text = pump?.turnOffCommand ?? '';
      _mqttMessageNameController.text = pump?.mqttMessageName ?? '';
    }

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _volumeCapacityController.dispose();
    _kwCapacityController.dispose();
    _onCommandController.dispose();
    _offCommandController.dispose();
    _mqttMessageNameController.dispose();
    _node.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _submitted = true);
    if (_formKey.currentState!.validate()) {
      // ask if user wants to save the pump
      final shouldSave = await showAlertDialog(
            context: context,
            title: context.loc.formGenericSaveDialogTitle,
            content: context.loc.formGenericSaveDialogContent(
              context.loc.nPumpsWithArticulatedPreposition(1),
            ),
            defaultActionText: context.loc.genericSaveButtonLabel,
            cancelActionText: context.loc.alertDialogCancel,
          ) ??
          false;

      if (!shouldSave) return;
      final toSave = _initialPump?.copyWith(
          id: _initialPump?.id,
          name: name,
          companyId: _initialPump?.companyId,
          capacityInVolume: double.tryParse(volumeCapacity) ?? 0.0,
          consumeRateInKw: double.tryParse(kwCapacity) ?? 0.0,
          turnOnCommand: onCommand,
          turnOffCommand: offCommand,
          mqttMessageName: mqttMessageName,
          hasFilter: _thisPumpHasFilter);

      if (toSave == _initialPump && _isUpdating) {
        debugPrint(
            'Form is valid, but no changes were made, not submitting...');
        _popScreen();
        return;
      }

      if (toSave == null) {
        debugPrint(
            'Form is valid, but pump to save is null, not submitting...');
        _popScreen();
        return;
      }

      debugPrint('Form is valid, submitting...');

      bool success = false;

      if (_isUpdating) {
        success = await ref
            .read(addUpdatePumpControllerProvider.notifier)
            .updatePump(toSave);
      } else {
        success = await ref
            .read(addUpdatePumpControllerProvider.notifier)
            .createPump(toSave);
      }

      if (success) {
        _popScreen();
      }

      return;
    }
  }

  void _popScreen() {
    context.pop();
  }

  /// Validates pump name field and mqtt message name field
  void _nameEditingComplete(
      {required List<String?> existingNames,
      required int maxLength,
      String? initialValue,
      required String value}) {
    if (canSubmitFormNameFields(
      value: value,
      maxLength: maxLength,
      namesToCompareAgainst: existingNames,
      initialValue: initialValue,
    )) {
      _node.nextFocus();
    }
  }

  /// Returns the error text for the name field
  String? _nameErrorText(
      {required List<String?> existingNames,
      required int maxLength,
      required String value,
      String? initialValue}) {
    if (!_submitted) return null;
    final errorKey = getFormNameFieldErrorKey(
      value: value,
      maxLength: maxLength,
      namesToCompareAgainst: existingNames,
      initialValue: initialValue,
    );

    if (errorKey == null) return null;
    final fieldName = context.loc.nPumps(1);
    return context.getLocalizedErrorText(
      errorKey: errorKey,
      fieldName: fieldName,
      maxFieldLength: maxLength,
    );
  }

  void _numericFieldsEditingComplete(String value) {
    if (canSubmitNumericFields(value: value)) {
      _node.nextFocus();
    }
  }

  String? _numericFieldsErrorText(String value) {
    if (!_submitted) return null;
    final errorKey = getNumericFieldsErrorKey(value: value);

    if (errorKey == null) return null;
    return context.getLocalizedErrorText(
      errorKey: errorKey,
    );
  }

  void _commandFieldsEditingComplete(
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

  String? _commandFieldsErrorText(
    String value,
    String counterpartValue,
    String? initialValue,
    List<String?> usedCommands,
  ) {
    if (!_submitted) return null;

    final loc = context.loc;
    final singularFieldName = loc.nPumps(1);
    final pluralFieldName = loc.nPumps(2);

    final errorKey = getCommandFieldErrorKey(
      value: value,
      counterpartValue: counterpartValue,
      initialValue: initialValue,
      valuesToCompareAgainst: usedCommands,
    );

    if (errorKey == null) return null;

    return context.getLocalizedErrorText(
        errorKey: errorKey,
        fieldName: singularFieldName,
        pluralFieldName: pluralFieldName);
  }

  @override
  Widget build(BuildContext context) {
    final numericFieldsKeyboardType =
        ref.watch(numericFieldsTextInputTypeProvider);
    final state = ref.watch(addUpdatePumpControllerProvider);

    final loc = context.loc;
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              AppSliverBar(
                title: _isUpdating
                    ? loc.updatePumpPageTitle
                    : loc.addNewPumpPageTitle,
              ),
              SliverToBoxAdapter(
                child: ResponsiveScrollable(
                  child: FocusScope(
                    node: _node,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          FormFieldCheckboxTile(
                            title: loc.itemHasFilter,
                            value: _thisPumpHasFilter,
                            onChanged: (value) => setState(
                              () => _thisPumpHasFilter = value ?? false,
                            ),
                          ),
                          gapH16,
                          // name field
                          Consumer(
                            builder: (context, ref, child) {
                              final usedPumpNames =
                                  ref.watch(companyUsedPumpNamesStreamProvider);
                              final value = usedPumpNames.valueOrNull ?? [];
                              return FormTitleAndField(
                                enabled: !state.isLoading,
                                fieldKey: _nameFieldKey,
                                fieldTitle: loc.nameFormFieldTitle,
                                fieldHintText: loc.pumpNameFormHint,
                                fieldController: _nameController,
                                textInputAction: TextInputAction.next,
                                validator: (_) => _nameErrorText(
                                  existingNames: value,
                                  value: name,
                                  maxLength: AppConstants.maxPumpNameLength,
                                  initialValue: _initialPump?.name,
                                ),
                                onEditingComplete: () => _nameEditingComplete(
                                  existingNames: value,
                                  maxLength: AppConstants.maxPumpNameLength,
                                  initialValue: _initialPump?.name,
                                  value: name,
                                ),
                              );
                            },
                          ),
                          gapH16,
                          // mqtt message name field
                          Consumer(
                            builder: (context, ref, child) {
                              final usedMqttNames = ref.watch(
                                  pumpUsedMqttMessageNamesStreamProvider);
                              final mqttNames = usedMqttNames.valueOrNull ?? [];
                              return FormTitleAndField(
                                enabled: !state.isLoading,
                                fieldKey: _mqttMessageNameFieldKey,
                                fieldTitle: loc.mqttMessageNameFormFieldTitle,
                                fieldHintText: loc.mqttMessageNameFormHint,
                                fieldController: _mqttMessageNameController,
                                textInputAction: TextInputAction.next,
                                validator: (_) => _nameErrorText(
                                  existingNames: mqttNames,
                                  value: mqttMessageName,
                                  maxLength:
                                      AppConstants.maxMqttMessageNameLength,
                                  initialValue: _initialPump?.mqttMessageName,
                                ),
                                onEditingComplete: () => _nameEditingComplete(
                                  existingNames: mqttNames,
                                  maxLength:
                                      AppConstants.maxMqttMessageNameLength,
                                  initialValue: _initialPump?.mqttMessageName,
                                  value: mqttMessageName,
                                ),
                              );
                            },
                          ),
                          gapH16,
                          // volume capacity field
                          FormTitleAndField(
                            enabled: !state.isLoading,
                            fieldKey: _volumeCapacityFieldKey,
                            fieldTitle: loc.pumpVolumeCapacityFormFieldTitle,
                            fieldHintText: loc.pumpVolumeCapacityFormHint,
                            fieldController: _volumeCapacityController,
                            textInputAction: TextInputAction.next,
                            validator: (value) =>
                                _numericFieldsErrorText(value ?? ''),
                            onEditingComplete: () =>
                                _numericFieldsEditingComplete(volumeCapacity),
                            keyboardType: numericFieldsKeyboardType,
                          ),
                          gapH16,
                          // kw capacity field
                          FormTitleAndField(
                            enabled: !state.isLoading,
                            fieldKey: _kwCapacityFieldKey,
                            fieldTitle: loc.pumpKwFormFieldTitle,
                            fieldHintText: loc.pumpKwFormHint,
                            fieldController: _kwCapacityController,
                            textInputAction: TextInputAction.next,
                            validator: (value) =>
                                _numericFieldsErrorText(value ?? ''),
                            onEditingComplete: () =>
                                _numericFieldsEditingComplete(kwCapacity),
                            keyboardType: numericFieldsKeyboardType,
                          ),
                          gapH16,
                          // on command field
                          Consumer(
                            builder: (context, ref, child) {
                              final usedCommands = ref
                                  .watch(companyUsedPumpCommandsStreamProvider);
                              final commands = usedCommands.valueOrNull ?? [];
                              return FormTitleAndField(
                                enabled: !state.isLoading,
                                fieldKey: _onCommandFieldKey,
                                fieldTitle: loc.onCommandFormFieldTitle,
                                fieldHintText: loc.onCommandFormHint,
                                fieldController: _onCommandController,
                                textInputAction: TextInputAction.next,
                                validator: (value) => _commandFieldsErrorText(
                                  value ?? '',
                                  offCommand,
                                  _initialPump?.turnOnCommand,
                                  commands,
                                ),
                                onEditingComplete: () =>
                                    _commandFieldsEditingComplete(
                                  onCommand,
                                  offCommand,
                                  _initialPump?.turnOnCommand,
                                  commands,
                                ),
                                keyboardType: numericFieldsKeyboardType,
                              );
                            },
                          ),

                          gapH16,
                          // off command field
                          Consumer(
                            builder: (context, ref, child) {
                              final usedCommands = ref
                                  .watch(companyUsedPumpCommandsStreamProvider);
                              final commands = usedCommands.valueOrNull ?? [];
                              return FormTitleAndField(
                                enabled: !state.isLoading,
                                fieldKey: _offCommandFieldKey,
                                fieldTitle: loc.offCommandFormFieldTitle,
                                fieldHintText: loc.offCommandFormHint,
                                fieldController: _offCommandController,
                                textInputAction: TextInputAction.done,
                                validator: (value) => _commandFieldsErrorText(
                                  value ?? '',
                                  onCommand,
                                  _initialPump?.turnOffCommand,
                                  commands,
                                ),
                                onEditingComplete: () =>
                                    _commandFieldsEditingComplete(
                                  offCommand,
                                  onCommand,
                                  _initialPump?.turnOffCommand,
                                  commands,
                                ),
                                keyboardType: numericFieldsKeyboardType,
                              );
                            },
                          ),
                          gapH16,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        gapH16,
        SliverCTAButton(
          isLoading: state.isLoading,
          text: !_isUpdating
              ? loc.genericSaveButtonLabel
              : loc.genericUpdateButtonLabel,
          buttonType: ButtonType.primary,
          onPressed: _submit,
        ),
        gapH32,
      ],
    );
  }
}
