import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:irrigazione_iot/src/config/enums/button_types.dart';
import 'package:irrigazione_iot/src/config/enums/form_types.dart';
import 'package:irrigazione_iot/src/config/routes/app_router.dart';
import 'package:irrigazione_iot/src/constants/app_constants.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_sector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector.dart';
import 'package:irrigazione_iot/src/features/collectors/screen/add_update_collector/add_update_collector_controller.dart';
import 'package:irrigazione_iot/src/utils/app_form_error_texts_extension.dart';
import 'package:irrigazione_iot/src/utils/app_form_validators.dart';
import 'package:irrigazione_iot/src/utils/async_value_ui.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/alert_dialogs.dart';
import 'package:irrigazione_iot/src/widgets/app_cta_button.dart';
import 'package:irrigazione_iot/src/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/widgets/form_title_and_field.dart';
import 'package:irrigazione_iot/src/widgets/responsive_sliver_form.dart';

class AddUpdateCollectorFormContents extends ConsumerStatefulWidget {
  const AddUpdateCollectorFormContents({
    super.key,
    this.collectorId,
    required this.formType,
  });

  final CollectorID? collectorId;
  final GenericFormTypes formType;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddUpdateCollectorFormContentsState();
}

class _AddUpdateCollectorFormContentsState
    extends ConsumerState<AddUpdateCollectorFormContents>
    with AppFormValidators {
  // general variables
  final _collectorFormNode = FocusScopeNode();
  final _collectorFormKey = GlobalKey<FormState>();

  // local variable used to apply AutovalidateMode.onUserInteraction and show
  // error hints only when the form has been submitted
  // For more details on how this is implemented, see:
  // https://codewithandrea.com/articles/flutter-text-field-form-validation/
  var _submitted = false;

  // form fields controller
  final _collectorNameController = TextEditingController();
  final _filterNameController = TextEditingController();

  // form field values
  String get _collectorName => _collectorNameController.text;
  String get _filterName => _filterNameController.text;

  // keys form testing
  static const _collectorNameKey = Key('collectorNameField');
  static const _filterNameKey = Key('filterNameField');
  static const _connectedSectorsKey = Key('connectedSectorsField');

  Collector? _initialCollector = const Collector.empty();

  @override
  void initState() {
    if (widget.formType.isUpdating && widget.collectorId != null) {
      final collector =
          ref.read(collectorStreamProvider(widget.collectorId!)).valueOrNull;
      _initialCollector = collector;
      _filterNameController.text = _initialCollector?.filterName ?? '';
      _collectorNameController.text = _initialCollector?.name ?? '';
    }
    super.initState();
  }

  @override
  void dispose() {
    _collectorNameController.dispose();
    _filterNameController.dispose();
    _collectorFormNode.dispose();
    super.dispose();
  }

  void _collectorNameEditingComplete(
      {required List<String?> usedCollectorNames}) {
    if (canSubmitFormNameFields(
        value: _collectorName,
        maxLength: AppConstants.maxCollectorNameLength,
        initialValue: _initialCollector?.name,
        namesToCompareAgainst: usedCollectorNames)) {
      _collectorFormNode.nextFocus();
    }
  }

  String? _collectorNameErrorText({
    required List<String?> usedCollectorNames,
  }) {
    if (!_submitted) return null;

    final errorKey = getFormNameFieldErrorKey(
      value: _collectorName,
      maxLength: AppConstants.maxCollectorNameLength,
      initialValue: _initialCollector?.name,
      namesToCompareAgainst: usedCollectorNames,
    );
    if (errorKey == null) return null;

    final fieldName = context.loc.nCollectors(1);
    return context.getLocalizedErrorText(
      errorKey: errorKey,
      fieldName: fieldName,
      maxFieldLength: AppConstants.maxCollectorNameLength,
    );
  }

  void _nonEmptyFieldsEditingComplete({required String value}) {
    if (canSubmitNonEmptyFields(value: value)) {
      _collectorFormNode.nextFocus();
    }
  }

  String? _nonEmptyFieldsErrorText({required String value}) {
    if (!_submitted) return null;
    return context.getLocalizedErrorText(
      errorKey: getNonEmptyFieldsErrorKey(value: value),
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

  Future<void> _submit() async {
    setState(() => _submitted = true);

    if (_collectorFormKey.currentState!.validate()) {
      if (await _checkUserIntention()) {
        final collector = _initialCollector?.copyWith(
          id: _initialCollector?.id,
          name: _collectorName,
          filterName: _filterName,
          companyId: _initialCollector?.companyId,
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

  void _popScreen() {
    ref.read(selectedSectorsIdProvider.notifier).state = [];
    context.popNavigator();
  }

  void _onTappedConnectedSectors() {
    context.pushNamed<int>(
      AppRoute.connectSectorToCollector.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    // listen to controller state and show alert dialog should any error
    // occur
    ref.listen(
      addUpdateCollectorControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final isUpdating = widget.formType.isUpdating;
    final loc = context.loc;
    final usedCollectorNames =
        ref.watch(usedCollectorNamesStreamProvider).valueOrNull ?? [];

    final state = ref.watch(addUpdateCollectorControllerProvider);
    final isLoading = state.isLoading;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              AppSliverBar(
                title: isUpdating
                    ? loc.updateCollectorPageTitle
                    : loc.addNewCollectorPageTitle,
              ),
              ResponsiveSliverForm(
                node: _collectorFormNode,
                formKey: _collectorFormKey,
                children: [
                  // name field
                  FormTitleAndField(
                    enabled: !isLoading,
                    fieldKey: _collectorNameKey,
                    fieldTitle: loc.collectorName,
                    fieldController: _collectorNameController,
                    fieldHintText: loc.collectorNameHintText,
                    onEditingComplete: () => _collectorNameEditingComplete(
                      usedCollectorNames: usedCollectorNames,
                    ),
                    validator: (_) => _collectorNameErrorText(
                      usedCollectorNames: usedCollectorNames,
                    ),
                  ),
                  gapH16,
                  // filter name field
                  FormTitleAndField(
                    enabled: !isLoading,
                    fieldKey: _filterNameKey,
                    fieldTitle: loc.collectorFilterName,
                    fieldController: _filterNameController,
                    fieldHintText: loc.collectorFilterNameHintText,
                    onEditingComplete: () => _nonEmptyFieldsEditingComplete(
                      value: _filterName,
                    ),
                    validator: (_) => _nonEmptyFieldsErrorText(
                      value: _filterName,
                    ),
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
          text: isUpdating
              ? loc.genericUpdateButtonLabel
              : loc.genericSaveButtonLabel,
          buttonType: ButtonType.primary,
          onPressed: _submit,
        )
      ],
    );
  }
}
