import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:irrigazione_iot/src/config/enums/button_types.dart';
import 'package:irrigazione_iot/src/config/enums/form_types.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/constants/app_constants.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_sector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector.dart';
import 'package:irrigazione_iot/src/features/collectors/screen/add_update_collector/add_update_collector_controller.dart';
import 'package:irrigazione_iot/src/shared/models/query_params.dart';
import 'package:irrigazione_iot/src/shared/widgets/alert_dialogs.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_cta_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/shared/widgets/form_field_checkbox.dart';
import 'package:irrigazione_iot/src/shared/widgets/form_title_and_field.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_sliver_form.dart';
import 'package:irrigazione_iot/src/utils/app_form_error_texts_extension.dart';
import 'package:irrigazione_iot/src/utils/app_form_validators.dart';
import 'package:irrigazione_iot/src/utils/extensions/extensions.dart';

class AddUpdateCollectorFormContents extends ConsumerStatefulWidget {
  const AddUpdateCollectorFormContents({
    super.key,
    this.collectorId,
    required this.formType,
  });

  final String? collectorId;
  final GenericFormTypes formType;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddUpdateCollectorFormContentsState();
}

class _AddUpdateCollectorFormContentsState
    extends ConsumerState<AddUpdateCollectorFormContents>
    with AppFormValidators {
  // general variables
  final _node = FocusScopeNode();
  final _collectorFormKey = GlobalKey<FormState>();

  // local variable used to apply AutovalidateMode.onUserInteraction and show
  // error hints only when the form has been submitted
  // For more details on how this is implemented, see:
  // https://codewithandrea.com/articles/flutter-text-field-form-validation/
  var _submitted = false;

  // form fields controller
  final _collectorNameController = TextEditingController();
  final _mqttMsgNameController = TextEditingController();

  // form field values
  String get _collectorName => _collectorNameController.text;
  String get _mqttMsgName => _mqttMsgNameController.text;

  // keys form testing
  static const _collectorNameKey = Key('collectorNameField');
  static const _connectedSectorsKey = Key('connectedSectorsField');
  static const _mqttMsgNameKey = Key('mqttMsgNameField');

  Collector? _initialCollector = const Collector.empty();

  bool _thisCollectorHasFilter = false;

  bool get _isUpdating => widget.formType.isUpdating;

  @override
  void initState() {
    if (_isUpdating && widget.collectorId != null) {
      final collector =
          ref.read(collectorStreamProvider(widget.collectorId!)).valueOrNull;
      _initialCollector = collector;
      _thisCollectorHasFilter = collector?.hasFilter ?? false;
      _collectorNameController.text = _initialCollector?.name ?? '';
      _mqttMsgNameController.text = _initialCollector?.mqttMsgName ?? '';
    }
    super.initState();
  }

  @override
  void dispose() {
    _collectorNameController.dispose();
    _node.dispose();
    _mqttMsgNameController.dispose();
    super.dispose();
  }

  void _nameEditingComplete({
    required List<String?> existingNames,
    required int maxLength,
    required String value,
    String? initialValue,
  }) {
    if (canSubmitFormNameFields(
      value: value,
      maxLength: maxLength,
      initialValue: initialValue,
      namesToCompareAgainst: existingNames,
    )) {
      _node.nextFocus();
    }
  }

  String? _nameErrorText({
    required List<String?> existingNames,
    required String value,
    required int maxLength,
    String? initialValue,
  }) {
    if (!_submitted) return null;

    final errorKey = getFormNameFieldErrorKey(
      value: value,
      maxLength: maxLength,
      initialValue: initialValue,
      namesToCompareAgainst: existingNames,
    );
    if (errorKey == null) return null;

    final fieldName = context.loc.nCollectors(1);
    return context.getLocalizedErrorText(
      errorKey: errorKey,
      fieldName: fieldName,
      maxFieldLength: AppConstants.maxCollectorNameLength,
    );
  }

  Future<bool> _checkUserIntention() async {
    final loc = context.loc;
    return await showAlertDialog(
          context: context,
          title: loc.formGenericSaveDialogTitle,
          content: loc.formGenericSaveDialogContent(
            loc.nCollectors(1),
          ),
          defaultActionText: loc.genericSaveButtonLabel,
          cancelActionText: loc.alertDialogCancel,
        ) ??
        false;
  }

  void _popScreen() {
    ref.read(selectedSectorsIdProvider.notifier).state = [];
    context.popNavigator();
  }

  void _onTappedConnectedSectors() {
    final queryParam = QueryParameters(
      id: widget.collectorId,
    ).toJson();
    context.pushNamed<int>(
      AppRoute.connectSectorToCollector.name,
      queryParameters: queryParam,
    );
  }

  Future<void> _submit() async {
    setState(() => _submitted = true);

    if (_collectorFormKey.currentState!.validate()) {
      if (await _checkUserIntention()) {
        final collector = _initialCollector?.copyWith(
          id: _initialCollector?.id,
          name: _collectorName,
          hasFilter: _thisCollectorHasFilter,
          mqttMsgName: _mqttMsgName,
        );

        bool success = false;
        success = widget.formType.isUpdating
            ? await ref
                .read(addUpdateCollectorControllerProvider.notifier)
                .updateCollector(
                  collectorToUpdate: collector,
                )
            : await ref
                .read(addUpdateCollectorControllerProvider.notifier)
                .createCollector(
                  collectorToCreate: collector,
                );

        if (success) {
          _popScreen();
          return;
        }
        return;
      } else {
        debugPrint('Form is valid but user chose not to save data');
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final state = ref.watch(addUpdateCollectorControllerProvider);
    final isLoading = state.isLoading;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              AppSliverBar(
                title: _isUpdating
                    ? loc.updateCollectorPageTitle
                    : loc.addNewCollectorPageTitle,
              ),
              ResponsiveSliverForm(
                node: _node,
                formKey: _collectorFormKey,
                children: [
                  // has filter field
                  FormFieldCheckboxTile(
                    title: loc.itemHasFilter,
                    value: _thisCollectorHasFilter,
                    onChanged: (value) => setState(
                      () => _thisCollectorHasFilter = value ?? false,
                    ),
                  ),
                  gapH16,
                  // name field
                  Consumer(
                    builder: (context, ref, child) {
                      final usedCollectorNames =
                          ref.watch(usedCollectorNamesStreamProvider);
                      final values = usedCollectorNames.valueOrNull ?? [];

                      return FormTitleAndField(
                        enabled: !isLoading,
                        fieldKey: _collectorNameKey,
                        fieldTitle: loc.collectorName,
                        fieldController: _collectorNameController,
                        fieldHintText: loc.collectorNameHintText,
                        onEditingComplete: () => _nameEditingComplete(
                          existingNames: values,
                          maxLength: AppConstants.maxCollectorNameLength,
                          value: _collectorName,
                          initialValue: _initialCollector?.name,
                        ),
                        validator: (_) => _nameErrorText(
                          existingNames: values,
                          value: _collectorName,
                          maxLength: AppConstants.maxCollectorNameLength,
                          initialValue: _initialCollector?.name,
                        ),
                      );
                    },
                  ),
                  gapH16,
                  // mqtt message name field
                  Consumer(
                    builder: (context, ref, child) {
                      final usedMqttNames = ref
                          .watch(collectorUsedMqttMessageNamesStreamProvider);
                      final values = usedMqttNames.valueOrNull ?? [];
                      return FormTitleAndField(
                        enabled: !isLoading,
                        fieldKey: _mqttMsgNameKey,
                        fieldTitle: loc.mqttMessageNameFormFieldTitle,
                        fieldController: _mqttMsgNameController,
                        fieldHintText: loc.mqttMessageNameFormHint,
                        onEditingComplete: () => _nameEditingComplete(
                          existingNames: values,
                          maxLength: AppConstants.maxMqttMessageNameLength,
                          value: _mqttMsgName,
                          initialValue: _initialCollector?.mqttMsgName,
                        ),
                        validator: (_) => _nameErrorText(
                          existingNames: values,
                          value: _mqttMsgName,
                          maxLength: AppConstants.maxMqttMessageNameLength,
                          initialValue: _initialCollector?.mqttMsgName,
                        ),
                      );
                    },
                  ),
                  gapH16,
                  // connected sectors
                  Consumer(
                    builder: (context, ref, child) {
                      final selectedSectors =
                          ref.watch(selectedSectorsIdProvider);
                      return FormTitleAndField(
                        enabled: !isLoading,
                        fieldKey: _connectedSectorsKey,
                        fieldTitle: loc.collectorConnectedSectors,
                        fieldHintText:
                            loc.nSelectedSectors(selectedSectors.length),
                        canRequestFocus: false,
                        keyboardType: TextInputType.none,
                        onTap: _onTappedConnectedSectors,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.arrow_drop_down),
                          onPressed: _onTappedConnectedSectors,
                        ),
                      );
                    },
                  )
                ],
              )
            ],
          ),
        ),
        gapH16,
        // button to save or update collector
        SliverCTAButton(
          isLoading: isLoading,
          text: _isUpdating
              ? loc.genericUpdateButtonLabel
              : loc.genericSaveButtonLabel,
          buttonType: ButtonType.primary,
          onPressed: _submit,
        )
      ],
    );
  }
}
