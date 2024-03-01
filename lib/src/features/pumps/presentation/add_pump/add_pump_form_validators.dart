import 'package:flutter/cupertino.dart';
import 'package:irrigazione_iot/src/constants/app_constants.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/utils/string_validators.dart';

/// Mixin class to be used for validating the form fields in the AddPumpScreen
mixin AddPumpFormValidators {
  // A general non-empty validators
  final StringValidator nonEmptyValidator = NonEmptyStringValidator();

  // Generic validators to check if the value is a number
  final StringValidator numericFieldsValidator = NumericEditingRegexValidator();

  // Validators for the name field, the constraints are
  // - non-empty
  // - max length of 50 characters
  final StringValidator nameMaxLengthValidator =
      MaxLengthStringValidator(AppConstants.maxPumpNameLength);

  bool valueIsGreaterThanZero(String value) {
    return double.tryParse(value) != null && double.parse(value) > 0;
  }

  bool canSubmitNameField(
    String name,
    String? initialValue,
    List<String?> usedPumpNames,
  ) {
    // If an initialValue was provided, which should be the case when updating a pump
    // and the name is the same as the initial value, then the name is valid without running
    // check against the usedPumpNames
    if (initialValue != null && name == initialValue) {
      return nonEmptyValidator.isValid(name) &&
          nameMaxLengthValidator.isValid(name);
    }
    return nonEmptyValidator.isValid(name) &&
        nameMaxLengthValidator.isValid(name) &&
        !usedPumpNames.contains(name);
  }

  bool canSubmitVolumeCapacityField(String value) {
    return nonEmptyValidator.isValid(value) &&
        numericFieldsValidator.isValid(value) &&
        valueIsGreaterThanZero(value);
  }

  bool canSubmitKwCapacityField(String value) {
    return nonEmptyValidator.isValid(value) &&
        numericFieldsValidator.isValid(value) &&
        valueIsGreaterThanZero(value);
  }

  bool canSubmitCommandFields(
    String value,
    String? initialValue,
    List<String?> usedCommands,
  ) {
    // If an initialValue was provided, which should be the case when updating a pump
    // and the command is the same as the initial value, then the command is valid without running
    // check against the usedCommands
    if (initialValue != null && value == initialValue) {
      return nonEmptyValidator.isValid(value) &&
          numericFieldsValidator.isValid(value);
    }
    return nonEmptyValidator.isValid(value) &&
        numericFieldsValidator.isValid(value) &&
        !usedCommands.contains(value);
  }

  String? nameErrorText(
    String name,
    String? initialValue,
    List<String?> usedPumpNames,
    BuildContext context,
  ) {
    if (name.isEmpty) {
      return context.loc.pumpNameEmptyErrorText;
    } else if (!nameMaxLengthValidator.isValid(name)) {
      return context.loc.pumpNameTooLongErrorText(
        AppConstants.maxPumpNameLength,
      );
    } else if (usedPumpNames.contains(name) && name != initialValue) {
      return context.loc.pumpNameAlreadyInUseErrorText;
    }
    return null;
  }

  String? volumeCapacityFieldErrorText(String value, BuildContext context) {
    if (value.isEmpty) {
      return context.loc.pumpGenericEmptyFormFieldErrorText;
    } else if (!numericFieldsValidator.isValid(value)) {
      return context.loc.pumpGenericNotANumberErrorText;
    } else if (!valueIsGreaterThanZero(value)) {
      return context.loc.pumpGenericNotGreaterThanZeroErrorText;
    }
    return null;
  }

  String? kwCapacityFieldErrorText(String value, BuildContext context) {
    if (value.isEmpty) {
      return context.loc.pumpGenericEmptyFormFieldErrorText;
    } else if (!numericFieldsValidator.isValid(value)) {
      return context.loc.pumpGenericNotANumberErrorText;
    } else if (!valueIsGreaterThanZero(value)) {
      return context.loc.pumpGenericNotGreaterThanZeroErrorText;
    }
    return null;
  }

  String? commandFieldsErrorText(
    String value,
    String? initialValue,
    List<String?> usedCommands,
    BuildContext context,
  ) {
    if (value.isEmpty) {
      return context.loc.pumpGenericEmptyFormFieldErrorText;
    } else if (!numericFieldsValidator.isValid(value)) {
      return context.loc.pumpGenericNotANumberErrorText;
    } else if (usedCommands.contains(value) && value != initialValue) {
      return context.loc.pumpCommandAlreadyInUseErrorText;
    }
    return null;
  }
}
