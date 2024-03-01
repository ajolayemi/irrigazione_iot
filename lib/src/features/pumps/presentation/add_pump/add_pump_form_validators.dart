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

  bool canSubmitNameField(String name, List<String?> usedPumpNames) {
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

  bool canSubmitCommandFields(String value, List<String?> usedCommands) {
    return nonEmptyValidator.isValid(value) &&
        numericFieldsValidator.isValid(value) && !usedCommands.contains(value);
  }

  String? nameErrorText(String name, BuildContext context, List<String?> usedPumpNames) {
    if (name.isEmpty) {
      return context.loc.pumpNameEmptyErrorText;
    } else if (!nameMaxLengthValidator.isValid(name)) {
      return context.loc.pumpNameTooLongErrorText(
        AppConstants.maxPumpNameLength,
      );
    } else if (usedPumpNames.contains(name)) {
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

  String? commandFieldsErrorText(String value, BuildContext context, List<String?> usedCommands) {
    if (value.isEmpty) {
      return context.loc.pumpGenericEmptyFormFieldErrorText;
    } else if (!numericFieldsValidator.isValid(value)) {
      return context.loc.pumpGenericNotANumberErrorText;
    } else if (usedCommands.contains(value)) {
      return context.loc.pumpCommandAlreadyInUseErrorText;
    }
    return null;
  }
}
