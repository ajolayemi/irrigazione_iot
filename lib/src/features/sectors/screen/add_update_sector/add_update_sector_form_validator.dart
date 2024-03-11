import 'package:irrigazione_iot/src/constants/app_constants.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/utils/string_validators.dart';

/// Mixin class to be used for validating the form fields in the AddUpdateSectorScreen
/// To avoid mixin class dependency on BuildContext, the methods that retrieves error
/// messages return the keys to access the said messages
/// An extension on BuildContext is used to get the localized error messages
mixin AddUpdateSectorValidators {
  // A general non-empty validators
  final StringValidator nonEmptyValidator = NonEmptyStringValidator();

  // Generic validators to check if the value is a number
  final StringValidator numericFieldsValidator = NumericEditingRegexValidator();

  // Validators for the name field, the constraints are
  // - non-empty
  // - max length of 20 characters
  final StringValidator nameMaxLengthValidator =
      MaxLengthStringValidator(AppConstants.maxSectorNameLength);

  bool canSubmitNameField(
    String name,
    String? initialValue,
    List<String?> usedSectorNames,
  ) {
    // If an initialValue was provided, which should be the case when updating a sector
    // and the name is the same as the initial value, then the name is valid without running
    // check against the usedSectorNames
    if (initialValue != null && name.toLowerCase() == initialValue.toLowerCase()) {
      return nonEmptyValidator.isValid(name) &&
          nameMaxLengthValidator.isValid(name);
    }
    return nonEmptyValidator.isValid(name) &&
        nameMaxLengthValidator.isValid(name) &&
        !usedSectorNames.contains(name.toLowerCase());
  }

  bool canSubmitCommandFields(
    String value,
    String counterpartValue,
    String? initialValue,
    List<String?> usedCommands,
  ) {
    // If an initialValue was provided, which should be the case when updating a sector
    // and the command is the same as the initial value, then the command is valid without running
    // check against the usedCommands
    if (initialValue != null && value == initialValue) {
      return nonEmptyValidator.isValid(value) &&
          numericFieldsValidator.isValid(value);
    }
    return nonEmptyValidator.isValid(value) &&
        numericFieldsValidator.isValid(value) &&
        !usedCommands.contains(value) &&
        value != counterpartValue;
  }

  // Validates form fields that shouldn't be empty
  bool canSubmitNonEmptyFields(String value) {
    return nonEmptyValidator.isValid(value);
  }

  // Validates form fields that should be numeric and greater than zero
  bool canSubmitNumericFields(String value) {
    return nonEmptyValidator.isValid(value) &&
        numericFieldsValidator.isValid(value) &&
        value.valueIsGreaterThanZero();
  }

  // Gets and return the key to access localized error messages
  // for the name field
  String? sectorNameErrorText(
    String name,
    String? initialValue,
    List<String?> usedSectorNames,
  ) {
    if (name.isEmpty) {
      return 'emptyFormFieldErrorText';
    } else if (!nameMaxLengthValidator.isValid(name)) {
      return 'fieldTooLongErrorText';
    } else if (usedSectorNames.contains(name.toLowerCase()) &&
        name.toLowerCase() != initialValue?.toLowerCase()) {
      return 'fieldValueAlreadyInUseErrorText';
    }
    return null;
  }

  // A single method to get the errors for fields on the form that
  // shouldn't be empty
  String? nonEmptyFieldsErrorText(String value) {
    if (value.isEmpty) {
      return 'emptyFormFieldErrorText';
    }
    return null;
  }

  // A single method to get the errors for fields on the form that
  // should be numeric and greater than zero
  String? numericFieldsErrorText(String value) {
    if (value.isEmpty) {
      return 'emptyFormFieldErrorText';
    } else if (!numericFieldsValidator.isValid(value)) {
      return 'notANumberErrorText';
    } else if (!value.valueIsGreaterThanZero()) {
      return 'notGreaterThanZeroErrorText';
    }
    return null;
  }

  String? commandFieldsErrorText(
    String value,
    String counterpartValue,
    String? initialValue,
    List<String?> usedCommands,
  ) {
    if (value.isEmpty) {
      return 'emptyFormFieldErrorText';
    } else if (!numericFieldsValidator.isValid(value)) {
      return 'notANumberErrorText';
    } else if (usedCommands.contains(value) && value != initialValue) {
      return 'commandAlreadyInUseErrorText';
    } else if (value == counterpartValue) {
      return 'duplicateCommandsInFormErrorText';
    }
    return null;
  }
}
