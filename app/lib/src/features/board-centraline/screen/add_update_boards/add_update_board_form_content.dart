import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:irrigazione_iot/src/config/enums/button_types.dart';
import 'package:irrigazione_iot/src/config/enums/form_types.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/constants/app_constants.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/board-centraline/data/board_repository.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board.dart';
import 'package:irrigazione_iot/src/features/board-centraline/screen/add_update_boards/add_update_board_controller.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_repository.dart';
import 'package:irrigazione_iot/src/shared/models/query_params.dart';
import 'package:irrigazione_iot/src/shared/models/radio_button_item.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_cta_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_form_suffix_icon.dart';
import 'package:irrigazione_iot/src/shared/widgets/form_title_and_field.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_sliver_form.dart';
import 'package:irrigazione_iot/src/utils/app_form_error_texts_extension.dart';
import 'package:irrigazione_iot/src/utils/app_form_validators.dart';
import 'package:irrigazione_iot/src/utils/extensions/extensions.dart';

class AddUpdateBoardFormContent extends ConsumerStatefulWidget {
  const AddUpdateBoardFormContent({
    super.key,
    required this.formType,
    this.boardID,
  });

  final String? boardID;
  final GenericFormTypes formType;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddUpdateBoardFormContentState();
}

class _AddUpdateBoardFormContentState
    extends ConsumerState<AddUpdateBoardFormContent> with AppFormValidators {
  // general variables
  final _node = FocusScopeNode();
  final _formKey = GlobalKey<FormState>();

  var _submitted = false;

  // fields controllers
  final _nameController = TextEditingController();
  final _modelController = TextEditingController();
  final _serialNumberController = TextEditingController();
  final _mqttMessageNameController = TextEditingController();
  final _connectedCollectorController = TextEditingController();

  // fields values
  String get _name => _nameController.text;
  String get _model => _modelController.text;
  String get _serialNumber => _serialNumberController.text;
  String get _mqttMsgName => _mqttMessageNameController.text;
  String get _connectedCollector => _connectedCollectorController.text;

  // Keys for testing
  static const _nameFieldKey = Key('boardNameField');
  static const _modelFieldKey = Key('boardModelField');
  static const _serialNumberFieldKey = Key('boardSerialNumberField');
  static const _mqttMsgNameFieldKey = Key('mqttMessageNameField');
  static const _selectedCollectorFieldKey = Key('boardSelectedCollectorField');

  Board? _initialBoard = const Board.empty();

  /// The id of the collector that is connected to the board
  /// that is being updated.
  String? _connectedCollectorId;

  RadioButtonItem? _selectedCollector;

  bool get _isUpdating => widget.formType.isUpdating;

  @override
  void initState() {
    if (_isUpdating && widget.boardID != null) {
      final board =
          ref.read(boardStreamProvider(boardID: widget.boardID!)).valueOrNull;
      _initialBoard = board;
      _nameController.text = _initialBoard?.name ?? '';
      _modelController.text = _initialBoard?.model ?? '';
      _serialNumberController.text = _initialBoard?.serialNumber ?? '';
      _mqttMessageNameController.text = _initialBoard?.mqttMsgName ?? '';

      if (board != null) {
        final selectedCollector = ref
            .read(collectorStreamProvider(
              board.collectorId,
            ))
            .valueOrNull;
        _selectedCollector = RadioButtonItem(
          label: selectedCollector?.name ?? '',
          value: selectedCollector?.id ?? '',
        );
        _connectedCollectorController.text = selectedCollector?.name ?? '';
        _connectedCollectorId = selectedCollector?.id;
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _modelController.dispose();
    _serialNumberController.dispose();
    _mqttMessageNameController.dispose();
    _connectedCollectorController.dispose();
    _node.dispose();
    super.dispose();
  }

  void _nameEditingComplete({
    required List<String?> existingNames,
    required String value,
    required int maxLength,
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

    final fieldName = context.loc.nBoards(1);

    return context.getLocalizedErrorText(
      errorKey: errorKey,
      fieldName: fieldName,
      maxFieldLength: AppConstants.maxBoardNameLength,
    );
  }

  void _nonEmptyFieldsEditingComplete({required String value}) {
    if (canSubmitNonEmptyFields(value: value)) {
      _node.nextFocus();
    }
  }

  String? _nonEmptyFieldsErrorText({required String value}) {
    if (!_submitted) return null;
    return context.getLocalizedErrorText(
      errorKey: getNonEmptyFieldsErrorKey(value: value),
    );
  }

  void _popScreen() => context.popNavigator();

  Future<void> _onTappedConnectedCollector() async {
    final queryParam = QueryParameters(
            id: _selectedCollector?.value,
            name: _selectedCollector?.label,
            previouslyConnectedId: _connectedCollectorId)
        .toJson();

    final selectedCollector = await context.pushNamed<RadioButtonItem>(
      AppRoute.connectCollectorToBoard.name,
      queryParameters: queryParam,
    );

    if (selectedCollector != null) {
      _connectedCollectorController.text = selectedCollector.label;
      _selectedCollector = selectedCollector;
    }
  }

  Future<void> _submit() async {
    _node.unfocus();
    setState(() => _submitted = true);

    if (_formKey.currentState!.validate()) {
      if (await context.showSaveUpdateDialog(
        isUpdating: _isUpdating,
        what: context.loc.nBoards(1),
      )) {
        final board = _initialBoard?.copyWith(
          name: _name,
          id: _initialBoard?.id,
          model: _model,
          serialNumber: _serialNumber,
          mqttMsgName: _mqttMsgName,
        );

        bool success = false;
        if (_isUpdating) {
          success = await ref
              .read(addUpdateBoardControllerProvider.notifier)
              .updateBoard(
                boardToUpdate: board,
                collectorIdToConnect: _selectedCollector?.value,
              );
        } else {
          success = await ref
              .read(addUpdateBoardControllerProvider.notifier)
              .createBoard(
                boardToCreate: board,
                collectorIdToConnect: _selectedCollector?.value,
              );
        }

        if (success) {
          _popScreen();
          return;
        }
        return;
      } else {
        debugPrint('Form data is valid but user chose not to save');
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final state = ref.watch(addUpdateBoardControllerProvider);
    final isLoading = state.isLoading;
    return GestureDetector(
      onTap: () => _node.unfocus(),
      child: IgnorePointer(
        ignoring: isLoading,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  AppSliverBar(
                    title: _isUpdating
                        ? loc.updateBoardPageTitle
                        : loc.addNewBoardPageTitle,
                  ),
                  ResponsiveSliverForm(
                    node: _node,
                    formKey: _formKey,
                    children: [
                      // Board name field
                      Consumer(
                        builder: (context, ref, child) {
                          final boardUsedNames =
                              ref.watch(usedBoardNamesStreamProvider);
                          final value = boardUsedNames.valueOrNull ?? [];
                          return FormTitleAndField(
                            fieldKey: _nameFieldKey,
                            fieldTitle: loc.nameFormFieldTitle,
                            fieldHintText: loc.boardNameHintText,
                            fieldController: _nameController,
                            onEditingComplete: () => _nameEditingComplete(
                              value: _name,
                              existingNames: value,
                              maxLength: AppConstants.maxBoardNameLength,
                              initialValue: _initialBoard?.name,
                            ),
                            validator: (_) => _nameErrorText(
                              value: _name,
                              existingNames: value,
                              maxLength: AppConstants.maxBoardNameLength,
                              initialValue: _initialBoard?.name,
                            ),
                          );
                        },
                      ),
                      gapH16,
                      // Board mqtt message name field
                      Consumer(
                        builder: (context, ref, child) {
                          final mqttMsgNames =
                              ref.watch(boardsUsedMqttNamesStreamProvider);
                          final value = mqttMsgNames.valueOrNull ?? [];

                          return FormTitleAndField(
                            fieldKey: _mqttMsgNameFieldKey,
                            fieldTitle: loc.mqttMessageNameFormFieldTitle,
                            fieldHintText: loc.mqttMessageNameFormHint,
                            fieldController: _mqttMessageNameController,
                            onEditingComplete: () => _nameEditingComplete(
                              value: _mqttMsgName,
                              existingNames: value,
                              maxLength: AppConstants.maxMqttMessageNameLength,
                              initialValue: _initialBoard?.mqttMsgName,
                            ),
                            validator: (_) => _nameErrorText(
                              value: _mqttMsgName,
                              existingNames: value,
                              maxLength: AppConstants.maxMqttMessageNameLength,
                              initialValue: _initialBoard?.mqttMsgName,
                            ),
                          );
                        },
                      ),
                      gapH16,
                      // Board model field
                      FormTitleAndField(
                        fieldKey: _modelFieldKey,
                        fieldTitle: loc.boardModel,
                        fieldHintText: loc.boardModelHintText,
                        fieldController: _modelController,
                        onEditingComplete: () =>
                            _nonEmptyFieldsEditingComplete(value: _model),
                        validator: (_) =>
                            _nonEmptyFieldsErrorText(value: _model),
                      ),
                      gapH16,
                      // Board serial number field
                      FormTitleAndField(
                        fieldKey: _serialNumberFieldKey,
                        fieldTitle: loc.boardSerialNumber,
                        fieldHintText: loc.boardSerialNumberHintText,
                        fieldController: _serialNumberController,
                        onEditingComplete: () => _nonEmptyFieldsEditingComplete(
                            value: _serialNumber),
                        validator: (_) =>
                            _nonEmptyFieldsErrorText(value: _serialNumber),
                      ),
                      gapH16,
                      FormTitleAndField(
                        fieldKey: _selectedCollectorFieldKey,
                        fieldTitle: loc.boardConnectedCollector,
                        fieldHintText: loc.selectAnOptionHintText,
                        fieldController: _connectedCollectorController,
                        canRequestFocus: false,
                        suffixIcon: CommonFormSuffixIcon(
                          onPressed: _onTappedConnectedCollector,
                        ),
                        onTap: _onTappedConnectedCollector,
                        onEditingComplete: () => _nonEmptyFieldsErrorText(
                            value: _connectedCollector),
                        validator: (_) => _nonEmptyFieldsErrorText(
                          value: _connectedCollector,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            gapH16,
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
        ),
      ),
    );
  }
}
