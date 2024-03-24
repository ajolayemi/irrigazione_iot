import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/utils/string_validators.dart';

/// A mixin that holds all validation logic for the various forms in the app
/// To avoid mixin class dependency on BuildContext, the methods that retrieves error
/// messages return the keys to access the said messages
/// An extension on BuildContext is used to get the localized error messages
// TODO: this validator should replace all other validators in the app
mixin AppFormValidators {
  // A general non empty field validator
  final StringValidator nonEmptyValidator = NonEmptyStringValidator();

  // Generic validators to check if the value is a number
  final StringValidator numericFieldsValidator = NumericEditingRegexValidator();

  /// holds the logic to check if the "name" fields of the various forms  are valid
  /// The constraints are:
  /// - non-empty
  /// - max length of the specified length
  /// - unique
  /// - case sensitive
  bool canSubmitFormNameFields({
    required String value,
    required int maxLength,
    String? initialValue,
    List<String?> namesToCompareAgainst = const [],
  }) {
    // if an initialValue was provided, which should be the case when updating
    // and the name is the same as the initial value, then the name is valid without running
    // check against the namesToCompareAgainst
    if (initialValue != null &&
        value.toLowerCase() == initialValue.toLowerCase()) {
      return nonEmptyValidator.isValid(value) &&
          MaxLengthStringValidator(maxLength).isValid(value);
    }
    return nonEmptyValidator.isValid(value) &&
        MaxLengthStringValidator(maxLength).isValid(value) &&
        !namesToCompareAgainst.contains(value.toLowerCase());
  }

  /// Get's the error message key for name fields
  /// The constraints are:
  /// - non-empty
  /// - max length of the specified length
  /// - unique
  String? getFormNameFieldErrorKey({
    required String value,
    required int maxLength,
    String? initialValue,
    List<String?> namesToCompareAgainst = const [],
  }) {
    if (value.isEmpty) {
      return 'emptyFormFieldErrorText';
    } else if (!MaxLengthStringValidator(maxLength).isValid(value)) {
      return 'fieldTooLongErrorText';
    } else if (namesToCompareAgainst.contains(value.toLowerCase()) &&
        value.toLowerCase() != initialValue?.toLowerCase()) {
      return 'fieldValueAlreadyInUseErrorText';
    }
    return null;
  }

  /// Holds the logic to check whether "command" fields in various forms are valid
  /// Command fields are those where the commands to be sent via MQTT to
  /// items like pumps to toggle their state are entered by user during creation
  /// of things like pumps, sectors and so on
  /// The constraints for validation are
  /// - non empty
  /// - unique (i.e the command isn't already in use in the same company)
  /// - numeric
  /// - the same value isn't entered for both on and off commands
  bool canSubmitCommandFields({
    required String value,
    required String counterpartValue,
    String? initialValue,
    List<String?> valuesToCompareAgainst = const [],
  }) {
    // if an initialValue was provided, which should be the case when updating
    // and the command is the same as the initial value, then the command is valid without running
    // check against the valuesToCompareAgainst
    if (initialValue != null && value == initialValue) {
      return nonEmptyValidator.isValid(value) &&
          numericFieldsValidator.isValid(value);
    }
    return nonEmptyValidator.isValid(value) &&
        numericFieldsValidator.isValid(value) &&
        !valuesToCompareAgainst.contains(value) &&
        value != counterpartValue;
  }

  /// Gets the error key for "command" fields in various forms
  /// Command fields are those where the commands to be sent via MQTT to
  /// items like pumps to toggle their state are entered by user during creation
  /// of things like pumps, sectors and so on
  /// The constraints for validation are
  /// - non empty
  /// - unique (i.e the command isn't already in use in the same company)
  /// - numeric
  /// - the same value isn't entered for both on and off commands
  String? getCommandFieldErrorKey({
    required String value,
    required String counterpartValue,
    String? initialValue,
    List<String?> valuesToCompareAgainst = const [],
  }) {
    if (value.isEmpty) {
      return 'emptyFormFieldErrorText';
    } else if (!numericFieldsValidator.isValid(value)) {
      return 'notANumberErrorText';
    } else if (valuesToCompareAgainst.contains(value) &&
        value != initialValue) {
      return 'commandAlreadyInUseErrorText';
    } else if (value == counterpartValue) {
      return 'duplicateCommandsInFormErrorText';
    }
    return null;
  }

  /// Validates form fields that shouldn't be empty
  bool canSubmitNonEmptyFields({required String value}) =>
      nonEmptyValidator.isValid(value);

  /// Gets the error key for form fields that shouldn't be empty
  String? getNonEmptyFieldsErrorKey({required String value}) {
    if (value.isEmpty) return 'emptyFormFieldErrorText';
    return null;
  }

  /// Holds logic to check whether form fields that should be numeric
  /// and > 0 are valid
  bool canSubmitNumericFields({required String value}) {
    return nonEmptyValidator.isValid(value) &&
        numericFieldsValidator.isValid(value) &&
        value.isGreaterThanZero;
  }

  /// Gets the error key for form fields that should be numeric
  /// and > 0
  String? getNumericFieldsErrorKey({required String value}) {
    if (value.isEmpty) {
      return 'emptyFormFieldErrorText';
    } else if (!numericFieldsValidator.isValid(value)) {
      return 'notANumberErrorText';
    } else if (!value.isGreaterThanZero) {
      return 'notGreaterThanZeroErrorText';
    }
    return null;
  }

  /// Holds the logic to validate whether can submit field where a collector
  /// to connect to a board is selected
  /// This is mainly used in the form to add or update boards
  bool canSubmitCollectorField({required String value}) =>
      nonEmptyValidator.isValid(value);

  /// Gets the error key for fields where a collector to connect to a board is selected
  /// This is mainly used in the form to add or update boards
  String? getCollectorFieldErrorKey({required String value}) {
    if (value.isEmpty) return 'noCollectorConnectedToBoardErrorText';
    return null;
  }

  /// Holds the logic to validate whether can submit email field
  bool canSubmitEmail({required String value}) =>
      EmailSubmitRegexValidator().isValid(value);

  /// Gets the error key for email field
  String? getEmailErrorKey({required String value}) {   
    if (value.isEmpty) {
      return 'emptyEmailErrorText';
    } else if (!EmailSubmitRegexValidator().isValid(value)) {
      return 'invalidEmailErrorText';
    }
    return null;
  }
}
