import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';

extension AppFormsErrorText on BuildContext {
  // method to get localized error messages for form fields
  String? getLocalizedErrorText({
    String? errorKey,
    String? fieldName,
    String? pluralFieldName,
    int? maxFieldLength,
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
      default:
        return null;
    }
  }
}
