import 'package:flutter/services.dart';

/// This file contains some helper functions used for string validation.

abstract class StringValidator {
  bool isValid(String value);
}

/// This class is used to validate a string using a regular expression.
class RegexValidator implements StringValidator {
  RegexValidator({required this.regexSource});
  final String regexSource;

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
}

class MinLengthStringValidator extends StringValidator {
  MinLengthStringValidator(this.minLength);
  final int minLength;

  @override
  bool isValid(String value) {
    return value.length >= minLength;
  }
}

class MaxLengthStringValidator extends StringValidator {
  MaxLengthStringValidator(this.maxLength);
  final int maxLength;

  @override
  bool isValid(String value) {
    return value.length <= maxLength;
  }
}


// Regex to validate that user entered a numeric value
class NumericEditingRegexValidator extends RegexValidator {
  NumericEditingRegexValidator() : super(regexSource: '^[0-9]+\\.?[0]*\$');
}