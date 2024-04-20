// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class RadioButtonReturnType extends Equatable {
  const RadioButtonReturnType({
    required this.value,
    required this.label,
  });
  final String value;
  final String label;

  @override
  List<Object> get props => [value, label];
}
