import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/constants/app_constants.dart';
import 'package:irrigazione_iot/src/utils/string_validators.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';

/// Mixin class to be used for client-side email & password validation
mixin EmailAndPasswordValidators {
  final StringValidator emailSubmitValidator = EmailSubmitRegexValidator();
  final StringValidator passwordSignInSubmitValidator =
      NonEmptyStringValidator();
  final StringValidator passwordMinLengthValidator =
      MinLengthStringValidator(AppConstants.minPasswordLength);

  bool canSubmitEmail(String email) {
    return emailSubmitValidator.isValid(email);
  }

  bool canSubmitPassword(String password) {
    return passwordSignInSubmitValidator.isValid(password) &&
        passwordMinLengthValidator.isValid(password);
  }

  String? emailErrorText(String email, BuildContext context) {
    final bool showErrorText = !canSubmitEmail(email);
    final String errorText = email.isEmpty
        ? context.loc.emptyEmailErrorText
        : context.loc.invalidEmailErrorText;
    return showErrorText ? errorText : null;
  }

  String? passwordErrorText(String password, BuildContext context) {
    final bool showErrorText = !canSubmitPassword(password);
    final String errorText = password.isEmpty
        ? context.loc.emptyPasswordErrorText
        : context.loc.shortPasswordErrorText(
            AppConstants.minPasswordLength,
          );
    return showErrorText ? errorText : null;
  }
}
