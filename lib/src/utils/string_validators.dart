import 'package:flutter/services.dart';

/// This file contains some helper functions used for string validation.

abstract class StringValidator {
  bool isValid(String value);
  bool isPartialValid(String value);
}

/// This class is used to validate a string using a regular expression.
class RegexValidator implements StringValidator {
  RegexValidator({required this.regexSource});
  final String regexSource;

  /// Returns true if the value matches the regular expression in its entirety.
  @override
  bool isValid(String value) {
    try {
      // https://regex101.com/
      final RegExp regex = RegExp(regexSource);
      final Iterable<Match> matches = regex.allMatches(value);
      for (final match in matches) {
        if (match.start == 0 && match.end == value.length) {
          return true;
        }
      }
      return false;
    } catch (e) {
      // Invalid regex
      assert(false, e.toString());
      return true;
    }
  }

  @override
  bool isPartialValid(String value) {
    try {
      // https://regex101.com/
      final RegExp regex = RegExp(regexSource);
      return regex.hasMatch(value);
    } catch (e) {
      // Invalid regex
      assert(false, e.toString());
      return true;
    }
  }
}

class ValidatorInputFormatter implements TextInputFormatter {
  ValidatorInputFormatter({required this.editingValidator});
  final StringValidator editingValidator;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final bool oldValueValid = editingValidator.isValid(oldValue.text);
    final bool newValueValid = editingValidator.isValid(newValue.text);
    if (oldValueValid && !newValueValid) {
      return oldValue;
    }
    return newValue;
  }
}

/// This class is used to validate a string that is not empty.
class EmailEditingRegexValidator extends RegexValidator {
  EmailEditingRegexValidator() : super(regexSource: '^(|\\S)+\$');
}

/// Used to validate a valid email address.
class EmailSubmitRegexValidator extends RegexValidator {
  EmailSubmitRegexValidator() : super(regexSource: '^\\S+@\\S+\\.\\S+\$');
}

class NonEmptyStringValidator extends StringValidator {
  @override
  bool isValid(String value) {
    return value.isNotEmpty;
  }
  
  @override
  bool isPartialValid(String value) {
    // TODO: implement isPartialValid
    throw UnimplementedError();
  }
}

class MinLengthStringValidator extends StringValidator {
  MinLengthStringValidator(this.minLength);
  final int minLength;

  @override
  bool isValid(String value) {
    return value.length >= minLength;
  }
  
  @override
  bool isPartialValid(String value) {
    // TODO: implement isPartialValid
    throw UnimplementedError();
  }
}

class MaxLengthStringValidator extends StringValidator {
  MaxLengthStringValidator(this.maxLength);
  final int maxLength;

  @override
  bool isValid(String value) {
    return value.length <= maxLength;
  }
  
  @override
  bool isPartialValid(String value) {
    // TODO: implement isPartialValid
    throw UnimplementedError();
  }
}

// Regex to validate that user entered a numeric value
class NumericEditingRegexValidator extends RegexValidator {
  NumericEditingRegexValidator() : super(regexSource: '^[0-9]+\\.?[0-9]*\$');
}

// Regex to validate that a password has at least a capital letter
class PasswordUppercaseValidator extends RegexValidator {
  PasswordUppercaseValidator() : super(regexSource: '[A-Z]');
}

// Regex to validate that a password has at least a lowercase letter
class PasswordLowercaseValidator extends RegexValidator {
  PasswordLowercaseValidator() : super(regexSource: '[a-z]');
}

// Regex to validate that a password has at least a digit
class PasswordDigitValidator extends RegexValidator {
  PasswordDigitValidator() : super(regexSource: '\\d');
}

// Regex to validate that a password has at least a special character
class PasswordSpecialCharacterValidator extends RegexValidator {
  PasswordSpecialCharacterValidator()
      : super(regexSource: '[!@#\$%^&*(),.?":{}|<>]');
}
