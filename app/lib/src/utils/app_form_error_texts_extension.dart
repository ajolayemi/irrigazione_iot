import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';


extension AppFormsErrorText on BuildContext {
  // method to get localized error messages for form fields
  String? getLocalizedErrorText({
    String? errorKey,
    String? fieldName,
    String? pluralFieldName,
    int? maxFieldLength,
    int? minFieldLength,
  }) {
    if (errorKey == null) return null;
    switch (errorKey) {
      case 'emptyFormFieldErrorText':
        return loc.emptyFormFieldErrorText;
      case 'fieldTooLongErrorText':
        return loc.fieldTooLongErrorText(maxFieldLength ?? 0);
      case 'fieldValueAlreadyInUseErrorText':
        return loc.fieldValueAlreadyInUseErrorText(fieldName ?? '');
      case 'notANumberErrorText':
        return loc.notANumberErrorText;
      case 'notGreaterThanZeroErrorText':
        return loc.notGreaterThanZeroErrorText;
      case 'commandAlreadyInUseErrorText':
        return loc.commandAlreadyInUseErrorText(fieldName ?? '');
      case 'duplicateCommandsInFormErrorText':
        return loc.duplicateCommandsInFormErrorText(pluralFieldName ?? '');
      case 'noPumpConnectedToSectorErrorText':
        return loc.noPumpConnectedToSectorErrorText;
      case 'noCollectorConnectedToBoardErrorText':
        return loc.noCollectorConnectedToBoardErrorText;
      case 'invalidEmailErrorText':
        return loc.invalidEmailErrorText;
      case 'emailAlreadyInUseErrorText':
        return loc.emailAlreadyInUseErrorText;
      case 'emptyPasswordErrorText':
        return loc.emptyPasswordErrorText;
      case 'shortPasswordErrorText':
        return loc.shortPasswordErrorText(minFieldLength ?? 0);
      case 'passwordsDoNotMatchErrorText':
        return loc.passwordsDoNotMatchErrorText;
      case 'invalidCredentialsErrorText':
        return loc.invalidCredentialsErrorText;
      case 'noUppercaseInPasswordErrorText':
        return loc.noUppercaseInPasswordErrorText;
      case 'noLowercaseInPasswordErrorText':
        return loc.noLowercaseInPasswordErrorText;
      case 'noNumberInPasswordErrorText':
        return loc.noNumberInPasswordErrorText;
      case 'noSpecialCharacterInPasswordErrorText':
        return loc.noSpecialCharacterInPasswordErrorText;
      default:
        return null;
    }
  }

  /// Get's localized message for form dependent fields
  /// A different method is defined so as not to cluster up the getLocalizedErrorText method
  String? getLocalizedDependentErrorText({
    String? errorKey,
    String? field1Name,
    String? field2Name,
  }) {
    if (errorKey == null) return null;
    switch (errorKey) {
      case 'dependentFieldsEmptyErrorText':
        return loc.dependentFieldsEmptyErrorText(field1Name ?? '', field2Name ?? '');
      default:
        return null;
    }
  }
}
