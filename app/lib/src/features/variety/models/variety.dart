import 'package:equatable/equatable.dart';
import 'package:irrigazione_iot/src/features/variety/models/variety_database_keys.dart';
import 'package:irrigazione_iot/src/utils/int_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'variety.g.dart';

@JsonSerializable()
class Variety extends Equatable {
  const Variety({
    required this.id,
    required this.name,
    this.createdAt,
  });

  @JsonKey(name: VarietyDatabaseKeys.id)
  @IntConverter()
  final String id;

  @JsonKey(name: VarietyDatabaseKeys.name)
  final String name;
  
  @JsonKey(name: VarietyDatabaseKeys.createdAt)
  final DateTime? createdAt;

  @override
  List<Object?> get props => [id, name, createdAt];

  factory Variety.fromJson(Map<String, dynamic> json) =>
      _$VarietyFromJson(json);

  Map<String, dynamic> toJson() => _$VarietyToJson(this);
}
