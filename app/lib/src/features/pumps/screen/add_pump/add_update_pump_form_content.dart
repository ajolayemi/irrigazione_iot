import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/enums/button_types.dart';
import '../../../../config/enums/form_types.dart';
import '../../../../constants/app_constants.dart';
import '../../../../constants/app_sizes.dart';
import '../../data/pump_repository.dart';
import '../../model/pump.dart';
import 'add_update_pump_controller.dart';
import 'add_pump_form_validators.dart';
import '../../../../utils/app_form_error_texts_extension.dart';
import '../../../../utils/extensions.dart';
import '../../../../utils/numeric_fields_text_type.dart';
import '../../../../widgets/alert_dialogs.dart';
import '../../../../widgets/app_cta_button.dart';
import '../../../../widgets/app_sliver_bar.dart';
import '../../../../widgets/form_title_and_field.dart';
import '../../../../widgets/responsive_scrollable.dart';

class AddUpdatePumpContents extends ConsumerStatefulWidget {
  const AddUpdatePumpContents({
    super.key,
    required this.formType,
    this.pumpId,
  });

  final GenericFormTypes formType;
  final PumpID? pumpId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddUpdatePumpContents();
}

class _AddUpdatePumpContents extends ConsumerState<AddUpdatePumpContents>
    with AddPumpFormValidators {
  final _formKey = GlobalKey<FormState>();

  // form fields controllers
  final _nameController = TextEditingController();
  final _volumeCapacityController = TextEditingController();
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

  // local variable used to apply AutovalidateMode.onUserInteraction and show
  // error hints only when the form has been submitted
  // For more details on how this is implemented, see:
  // https://codewithandrea.com/articles/flutter-text-field-form-validation/
  var _submitted = false;

  Pump? _initialPump = const Pump.empty();
  static const _nameFieldKey = Key('name');
  static const _volumeCapacityFieldKey = Key('volumeCapacity');
  static const _kwCapacityFieldKey = Key('kwCapacity');
  static const _onCommandFieldKey = Key('onCommand');
  static const _offCommandFieldKey = Key('offCommand');

  @override
  void initState() {
    if (widget.formType == GenericFormTypes.update && widget.pumpId != null) {
      final pump = ref.read(pumpStreamProvider(widget.pumpId!)).valueOrNull;
      _initialPump = pump;
      _nameController.text = pump?.name ?? '';
      _volumeCapacityController.text = pump?.capacityInVolume.toString() ?? '';
      _kwCapacityController.text = pump?.consumeRateInKw.toString() ?? '';
      _onCommandController.text = pump?.commandForOn ?? '';
      _offCommandController.text = pump?.commandForOff ?? '';
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
    _node.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final updating = widget.formType == GenericFormTypes.update;
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
        commandForOn: onCommand,
        commandForOff: offCommand,
      );

      if (toSave == _initialPump && updating) {
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

      if (widget.formType == GenericFormTypes.add) {
        final success =
            await ref.read(addUpdatePumpControllerProvider.notifier).createPump(
                  toSave,
                );
        if (success) {
          _popScreen();
        }
      } else {
        final success =
            await ref.read(addUpdatePumpControllerProvider.notifier).updatePump(
                  toSave,
                );
        if (success) {
          _popScreen();
        }
      }
    }
  }

  void _popScreen() {
    context.pop();
  }

  void _nameEditingComplete(List<String?> existingNames) {
    if (canSubmitNameField(name, _initialPump?.name, existingNames)) {
      _node.nextFocus();
    }
  }

  String? _nameErrorText(List<String?> existingNames) {
    if (!_submitted) return null;
    final errorKey = nameErrorKey(name, _initialPump?.name, existingNames);

    if (errorKey == null) return null;
    final fieldName = context.loc.nPumps(1);
    return context.getLocalizedErrorText(
      errorKey: errorKey,
      fieldName: fieldName,
      maxFieldLength: AppConstants.maxPumpNameLength,
    );
  }

  void _numericFieldsEditingComplete(String value) {
    if (canSubmitNumericFields(value)) {
      _node.nextFocus();
    }
  }

  String? _numericFieldsErrorText(String value) {
    if (!_submitted) return null;
    final errorKey = numericFieldsErrorKey(value);

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
      value,
      counterpartValue,
      initialValue,
      usedCommands,
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

    final errorKey = commandFieldsErrorKey(
      value,
      counterpartValue,
      initialValue,
      usedCommands,
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
    final usedPumpNames =
        ref.watch(companyUsedPumpNamesStreamProvider).valueOrNull ?? [];
    final usedOnCommands =
        ref.watch(companyUsedPumpOnCommandsStreamProvider).valueOrNull ?? [];
    final usedOffCommands =
        ref.watch(companyUsedPumpOffCommandsStreamProvider).valueOrNull ?? [];
    final state = ref.watch(addUpdatePumpControllerProvider);

    final isUpdating = widget.formType.isUpdating;

    final loc = context.loc;
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              AppSliverBar(
                title: isUpdating
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
                          FormTitleAndField(
                            enabled: !state.isLoading,
                            fieldKey: _nameFieldKey,
                            fieldTitle: loc.pumpNameFormFieldTitle,
                            fieldHintText: loc.pumpNameFormHint,
                            fieldController: _nameController,
                            textInputAction: TextInputAction.next,
                            validator: (_) => _nameErrorText(usedPumpNames),
                            onEditingComplete: () =>
                                _nameEditingComplete(usedPumpNames),
                          ),
                          gapH16,
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
                          FormTitleAndField(
                            enabled: !state.isLoading,
                            fieldKey: _onCommandFieldKey,
                            fieldTitle: loc.pumpOnCommandFormFieldTitle,
                            fieldHintText: loc.pumpOnCommandFormHint,
                            fieldController: _onCommandController,
                            textInputAction: TextInputAction.next,
                            validator: (value) => !_submitted
                                ? null
                                : _commandFieldsErrorText(
                                    value ?? '',
                                    offCommand,
                                    _initialPump?.commandForOn,
                                    usedOnCommands,
                                  ),
                            onEditingComplete: () =>
                                _commandFieldsEditingComplete(
                              onCommand,
                              offCommand,
                              _initialPump?.commandForOn,
                              usedOnCommands,
                            ),
                            keyboardType: numericFieldsKeyboardType,
                          ),
                          gapH16,
                          FormTitleAndField(
                            enabled: !state.isLoading,
                            fieldKey: _offCommandFieldKey,
                            fieldTitle: loc.pumpOffCommandFormFieldTitle,
                            fieldHintText: loc.pumpOffCommandFormHint,
                            fieldController: _offCommandController,
                            textInputAction: TextInputAction.done,
                            validator: (value) => !_submitted
                                ? null
                                : _commandFieldsErrorText(
                                    value ?? '',
                                    onCommand,
                                    _initialPump?.commandForOff,
                                    usedOffCommands,
                                  ),
                            onEditingComplete: () =>
                                _commandFieldsEditingComplete(
                              offCommand,
                              onCommand,
                              _initialPump?.commandForOff,
                              usedOffCommands,
                            ),
                            keyboardType: numericFieldsKeyboardType,
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
          text: !isUpdating
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