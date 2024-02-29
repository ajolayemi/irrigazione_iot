import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/config/enums/button_types.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/app_cta_button.dart';
import 'package:irrigazione_iot/src/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/widgets/form_title_and_field.dart';
import 'package:irrigazione_iot/src/widgets/responsive_scrollable.dart';

import 'package:irrigazione_iot/src/features/pumps/presentation/add_pump/presentation/add_pump_form_validators.dart';

class AddPumpScreen extends ConsumerStatefulWidget {
  const AddPumpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddPumpScreenState();
}

class _AddPumpScreenState extends ConsumerState<AddPumpScreen>
    with AddPumpFormValidators {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _volumeCapacityController = TextEditingController();
  final _kwCapacityController = TextEditingController();
  final _onCommandController = TextEditingController();
  final _offCommandController = TextEditingController();

  final _node = FocusScopeNode();

  final _numericFieldsKeyboardType = const TextInputType.numberWithOptions(signed: true);

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

  Future<void> _submit() async {
    _node.unfocus();
    setState(() => _submitted = true);
    if (_formKey.currentState!.validate()) {
      debugPrint('Form is valid, submitting...');
    }
  }

  void _nameEditingComplete() {
    if (canSubmitNameField(name)) {
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

  void _onCommandEditingComplete() {
    if (canSubmitCommandFields(onCommand)) {
      _node.nextFocus();
    }
  }

  void _offCommandEditingComplete() {
    if (!canSubmitCommandFields(offCommand)) {
      _node.previousFocus();
      return;
    }

    _submit();
  }

  @override
  Widget build(BuildContext context) {
    const state = true; // todo replace with actual state
    return Scaffold(
      body: CustomScrollView(
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
                        enabled: state, // todo replace with state loading
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
                              ),
                        onEditingComplete: () => _nameEditingComplete(),
                      ),
                      gapH16,
                      FormTitleAndField(
                        enabled: state, // todo replace with state loading
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
                        enabled: state, // todo replace with state loading
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
                        enabled: state, // todo replace with state loading
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
                              ),
                        onEditingComplete: () => _onCommandEditingComplete(),
                        keyboardType: _numericFieldsKeyboardType,
                      ),
                      gapH16,
                      FormTitleAndField(
                        enabled: state, // todo replace with state loading
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
                              ),
                        onEditingComplete: () => _offCommandEditingComplete(),
                        keyboardType: _numericFieldsKeyboardType,
                
                      ),
                      gapH16,
                      CTAButton(
                        text: context.loc.genericSaveButtonLabel,
                        buttonType: ButtonType.primary,
                        onPressed: _submit, // todo activate button
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // SliverToBoxAdapter(
          //   child: CTAButton(
          //     text: 'Save',
          //     buttonType: ButtonType.primary,
          //     onPressed: () {},
          //   ),
          // )
        ],
      ),
    );
  }
}
