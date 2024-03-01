import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/enums/button_types.dart';
import 'package:irrigazione_iot/src/config/enums/form_types.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/domain/pump.dart';
import 'package:irrigazione_iot/src/features/pumps/presentation/add_pump/add_update_pump_controller.dart';
import 'package:irrigazione_iot/src/features/pumps/presentation/add_pump/add_pump_form_validators.dart';
import 'package:irrigazione_iot/src/utils/async_value_ui.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/alert_dialogs.dart';
import 'package:irrigazione_iot/src/widgets/app_cta_button.dart';
import 'package:irrigazione_iot/src/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/widgets/form_title_and_field.dart';
import 'package:irrigazione_iot/src/widgets/responsive_scrollable.dart';

class AddAndUpdatePumpContents extends ConsumerStatefulWidget {
  const AddAndUpdatePumpContents({
    super.key,
    required this.formType,
  });

  final AddAndCreatePumpFormTypes formType;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddPumpScreenState();
}

class _AddPumpScreenState extends ConsumerState<AddAndUpdatePumpContents>
    with AddPumpFormValidators {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _volumeCapacityController = TextEditingController();
  final _kwCapacityController = TextEditingController();
  final _onCommandController = TextEditingController();
  final _offCommandController = TextEditingController();

  final _node = FocusScopeNode();

  final _numericFieldsKeyboardType =
      const TextInputType.numberWithOptions(signed: true);

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

  static const _nameFieldKey = Key('name');
  static const _volumeCapacityFieldKey = Key('volumeCapacity');
  static const _kwCapacityFieldKey = Key('kwCapacity');
  static const _onCommandFieldKey = Key('onCommand');
  static const _offCommandFieldKey = Key('offCommand');

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

  // todo call the controller to add or update the pump
  Future<void> _submit() async {
    setState(() => _submitted = true);
    if (_formKey.currentState!.validate()) {
      // ask if user wants to save the pump
      final shouldSave = await showAlertDialog(
            context: context,
            title: context.loc.pumpFormGenericSaveDialogTitle,
            content: context.loc.pumpFormGenericSaveDialogContent,
            defaultActionText: context.loc.genericSaveButtonLabel,
            cancelActionText: context.loc.alertDialogCancel,
          ) ??
          false;

      if (!shouldSave) return;
      final toSave = const Pump.empty().copyWith(
        name: name,
        capacityInVolume: double.tryParse(volumeCapacity),
        consumeRateInKw: double.tryParse(kwCapacity),
        commandForOn: onCommand,
        commandForOff: offCommand,
      );

      debugPrint('Form is valid, submitting...');
      debugPrint(toSave.toMap().toString());

      if (widget.formType == AddAndCreatePumpFormTypes.addPump) {
        final success =
            await ref.read(addUpdatePumpControllerProvider.notifier).addPump(
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
    if (canSubmitNameField(name, existingNames)) {
      _node.nextFocus();
    }
  }

  void _volumeCapacityEditingComplete() {
    if (canSubmitVolumeCapacityField(volumeCapacity)) {
      _node.nextFocus();
    }
  }

  void _kwCapacityEditingComplete() {
    if (canSubmitKwCapacityField(kwCapacity)) {
      _node.nextFocus();
    }
  }

  void _onCommandEditingComplete(List<String?> existingOnCommands) {
    if (canSubmitCommandFields(onCommand, existingOnCommands)) {
      _node.nextFocus();
    }
  }

  void _offCommandEditingComplete(List<String?> existingOffCommands) {
    if (!canSubmitCommandFields(offCommand, existingOffCommands)) {
      _node.previousFocus();
      return;
    }

    _submit();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(addUpdatePumpControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    final usedPumpNames =
        ref.watch(companyUsedPumpNamesStreamProvider).valueOrNull ?? [];
    final usedOnCommands =
        ref.watch(companyUsedPumpOnCommandsStreamProvider).valueOrNull ?? [];
    final usedOffCommands =
        ref.watch(companyUsedPumpOffCommandsStreamProvider).valueOrNull ?? [];
    final state = ref.watch(addUpdatePumpControllerProvider);
    return CustomScrollView(
      slivers: [
        AppSliverBar(title: context.loc.addNewPumpPageTitle),
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
                      fieldTitle: context.loc.pumpNameFormFieldTitle,
                      fieldHintText: context.loc.pumpNameFormHint,
                      fieldController: _nameController,
                      textInputAction: TextInputAction.next,
                      validator: (name) => !_submitted
                          ? null
                          : nameErrorText(
                              name ?? '',
                              context,
                              ref
                                      .read(companyUsedPumpNamesStreamProvider)
                                      .valueOrNull ??
                                  [],
                            ),
                      onEditingComplete: () =>
                          _nameEditingComplete(usedPumpNames),
                    ),
                    gapH16,
                    FormTitleAndField(
                      enabled: !state.isLoading,
                      fieldKey: _volumeCapacityFieldKey,
                      fieldTitle: context.loc.pumpVolumeCapacityFormFieldTitle,
                      fieldHintText: context.loc.pumpVolumeCapacityFormHint,
                      fieldController: _volumeCapacityController,
                      textInputAction: TextInputAction.next,
                      validator: (value) => !_submitted
                          ? null
                          : volumeCapacityFieldErrorText(
                              value ?? '',
                              context,
                            ),
                      onEditingComplete: () => _volumeCapacityEditingComplete(),
                      keyboardType: _numericFieldsKeyboardType,
                    ),
                    gapH16,
                    FormTitleAndField(
                      enabled: !state.isLoading,
                      fieldKey: _kwCapacityFieldKey,
                      fieldTitle: context.loc.pumpKwFormFieldTitle,
                      fieldHintText: context.loc.pumpKwFormHint,
                      fieldController: _kwCapacityController,
                      textInputAction: TextInputAction.next,
                      validator: (value) => !_submitted
                          ? null
                          : kwCapacityFieldErrorText(
                              value ?? '',
                              context,
                            ),
                      onEditingComplete: () => _kwCapacityEditingComplete(),
                      keyboardType: _numericFieldsKeyboardType,
                    ),
                    gapH16,
                    FormTitleAndField(
                      enabled: !state.isLoading,
                      fieldKey: _onCommandFieldKey,
                      fieldTitle: context.loc.pumpOnCommandFormFieldTitle,
                      fieldHintText: context.loc.pumpOnCommandFormHint,
                      fieldController: _onCommandController,
                      textInputAction: TextInputAction.next,
                      validator: (value) => !_submitted
                          ? null
                          : commandFieldsErrorText(
                              value ?? '',
                              context,
                              ref
                                      .read(
                                          companyUsedPumpOnCommandsStreamProvider)
                                      .valueOrNull ??
                                  [],
                            ),
                      onEditingComplete: () =>
                          _onCommandEditingComplete(usedOnCommands),
                      keyboardType: _numericFieldsKeyboardType,
                    ),
                    gapH16,
                    FormTitleAndField(
                      enabled: !state.isLoading,
                      fieldKey: _offCommandFieldKey,
                      fieldTitle: context.loc.pumpOffCommandFormFieldTitle,
                      fieldHintText: context.loc.pumpOffCommandFormHint,
                      fieldController: _offCommandController,
                      textInputAction: TextInputAction.done,
                      validator: (value) => !_submitted
                          ? null
                          : commandFieldsErrorText(
                              value ?? '',
                              context,
                              ref
                                      .read(
                                          companyUsedPumpOffCommandsStreamProvider)
                                      .valueOrNull ??
                                  []),
                      onEditingComplete: () =>
                          _offCommandEditingComplete(usedOffCommands),
                      keyboardType: _numericFieldsKeyboardType,
                    ),
                    gapH16,
                    CTAButton(
                      isLoading: state.isLoading,
                      text: widget.formType == AddAndCreatePumpFormTypes.addPump
                          ? context.loc.genericSaveButtonLabel
                          : context.loc.genericUpdateButtonLabel,
                      buttonType: ButtonType.primary,
                      onPressed: state.isLoading ? null : _submit,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
