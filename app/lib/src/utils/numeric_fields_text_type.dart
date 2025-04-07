import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'numeric_fields_text_type.g.dart';

@riverpod
TextInputType numericFieldsTextInputType(NumericFieldsTextInputTypeRef ref) {
  return const TextInputType.numberWithOptions(signed: true, decimal: true);
}
