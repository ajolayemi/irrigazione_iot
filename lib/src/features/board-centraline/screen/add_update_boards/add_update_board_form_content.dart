import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/enums/form_types.dart';
import 'package:irrigazione_iot/src/constants/app_constants.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/board-centraline/data/board_repository.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector.dart';
import 'package:irrigazione_iot/src/utils/app_form_error_texts_extension.dart';
import 'package:irrigazione_iot/src/utils/app_form_validators.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/alert_dialogs.dart';
import 'package:irrigazione_iot/src/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/widgets/form_title_and_field.dart';
import 'package:irrigazione_iot/src/widgets/responsive_sliver_form.dart';

class AddUpdateBoardFormContent extends ConsumerStatefulWidget {
  const AddUpdateBoardFormContent({
    super.key,
    required this.formType,
    this.boardID,
  });

  final BoardID? boardID;
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
  final _connectedCollectorController = TextEditingController();

  // fields values
  String get _name => _nameController.text;
  String get _model => _modelController.text;
  String get _serialNumber => _serialNumberController.text;
  String get _collector => _connectedCollectorController.text;

  // Keys for testing
  static const _nameFieldKey = Key('boardNameField');
  static const _modelFieldKey = Key('boardModelField');
  static const _serialNumberFieldKey = Key('boardSerialNumberField');
  static const _collectorFieldKey = Key('boardCollectorField');

  Board? _initialBoard = const Board.empty();

  bool get _isUpdating => widget.formType.isUpdating;

  @override
  void initState() {
    if (_isUpdating && widget.boardID != null) {
      final board =
          ref.watch(boardStreamProvider(boardID: widget.boardID!)).valueOrNull;
      final collectorName = ref
          .watch(collectorStreamProvider(board?.collectorId ?? ''))
          .valueOrNull
          ?.name;
      _initialBoard = board;
      _nameController.text = _initialBoard?.name ?? '';
      _modelController.text = _initialBoard?.model ?? '';
      _serialNumberController.text = _initialBoard?.serialNumber ?? '';
      _connectedCollectorController.text = collectorName ?? '';
    }
    super.initState();
  }

  @override
  void dispose() {
    _connectedCollectorController.dispose();
    _nameController.dispose();
    _modelController.dispose();
    _serialNumberController.dispose();
    _node.dispose();
    super.dispose();
  }

  void _boardNameEditingComplete() {
    if (canSubmitFormNameFields(
      value: _name,
      maxLength: AppConstants.maxBoardNameLength,
      initialValue: _initialBoard?.name,
    )) {
      _node.nextFocus();
    }
  }

  String? _boardNameFieldErrorText() {
    if (!_submitted) return null;

    final errorKey = getFormNameFieldErrorKey(
      value: _name,
      maxLength: AppConstants.maxBoardNameLength,
      initialValue: _initialBoard?.name,
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

  Future<bool> _checkUserIntention() async {
    final loc = context.loc;
    return await showAlertDialog(
          context: context,
          title: _isUpdating
              ? loc.formGenericUpdateDialogTitle
              : loc.formGenericSaveDialogTitle,
          content: loc.formGenericSaveDialogContent(
            loc.nBoards(1),
          ),
          defaultActionText: _isUpdating
              ? loc.genericUpdateButtonLabel
              : loc.genericSaveButtonLabel,
          cancelActionText: loc.alertDialogCancel,
        ) ??
        false;
  }

  Future<void> _submit() async {
    setState(() => _submitted = true);

    if (_formKey.currentState!.validate()) {
      if (await _checkUserIntention()) {
        print('to save....');
      } else {
        debugPrint('Form data is valid but user chose not to save');
      }
    } else {}
  }

  void _popScreen() {
    ref.read(collectorConnectedToBoardProvider.notifier).state = null;
    context.popNavigator();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: loisten to controller error state here
    final loc = context.loc;

    // TODO: replace with proper controller state
    const state = false;
    const isLoading = false;
    return IgnorePointer(
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
                  FormTitleAndField(
                    fieldKey: _nameFieldKey,
                    fieldTitle: loc.boardName,
                    fieldHintText: loc.boardNameHintText,
                    fieldController: _nameController,
                    onEditingComplete: _boardNameEditingComplete,
                    validator: (_) => _boardNameFieldErrorText(),
                  ),
                  gapH16,
                  FormTitleAndField(
                    fieldKey: _modelFieldKey,
                    fieldTitle: loc.boardModel,
                    fieldHintText: loc.boardModelHintText,
                    fieldController: _modelController,
                    onEditingComplete: () =>
                        _nonEmptyFieldsEditingComplete(value: _model),
                    validator: (_) => _nonEmptyFieldsErrorText(value: _model),
                  ),
                ],
              ),
            ],
          ))
        ],
      ),
    );
  }
}
