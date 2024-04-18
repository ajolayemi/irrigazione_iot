import 'package:json_annotation/json_annotation.dart';

/// Used for serializing and deserializing integers from and to strings.

class IntConverter implements JsonConverter<String, int> {
  const IntConverter();

  @override
  String fromJson(int json) => json.toString();

  @override
  int toJson(String object) => int.parse(object);
}
