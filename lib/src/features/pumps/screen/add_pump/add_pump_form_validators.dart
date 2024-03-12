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
        !usedPumpNames.contains(name.toLowerCase());
  }

  bool canSubmitNumericFields(String value) {
    return nonEmptyValidator.isValid(value) &&
        numericFieldsValidator.isValid(value) &&
        value.valueIsGreaterThanZero();
  }


  bool canSubmitCommandFields(
    String value,
    String counterpartValue,
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
        !usedCommands.contains(value) &&
        value != counterpartValue;
  }

  String? nameErrorText(
    String name,
    String? initialValue,
    List<String?> usedPumpNames,
    BuildContext context,
  ) {
    if (name.isEmpty) {
      return context.loc.emptyFormFieldErrorText;
    } else if (!nameMaxLengthValidator.isValid(name)) {
      return context.loc.fieldTooLongErrorText(
        AppConstants.maxPumpNameLength,
      );
    } else if (usedPumpNames.contains(name.toLowerCase()) &&
        name != initialValue) {
      final fieldName = context.loc.nPumps(1);
      return context.loc.fieldValueAlreadyInUseErrorText(fieldName);
    }
    return null;
  }

  String? numericFieldsErrorText(String value, BuildContext context) {
    if (value.isEmpty) {
      return context.loc.emptyFormFieldErrorText;
    } else if (!numericFieldsValidator.isValid(value)) {
      return context.loc.notANumberErrorText;
    } else if (!value.valueIsGreaterThanZero()) {
      return context.loc.notGreaterThanZeroErrorText;
    }
    return null;
  }
  
  String? commandFieldsErrorText(
    String value,
    String counterpartValue,
    String? initialValue,
    List<String?> usedCommands,
    BuildContext context,
  ) {
    if (value.isEmpty) {
      return context.loc.emptyFormFieldErrorText;
    } else if (!numericFieldsValidator.isValid(value)) {
      return context.loc.notANumberErrorText;
    } else if (usedCommands.contains(value) && value != initialValue) {
      final fieldName = context.loc.nPumps(1);
      return context.loc.commandAlreadyInUseErrorText(fieldName);
    } else if (value == counterpartValue) {
      final fieldName = context.loc.nPumps(2);
      return context.loc.duplicateCommandsInFormErrorText(fieldName);
    }
    return null;
  }
}
