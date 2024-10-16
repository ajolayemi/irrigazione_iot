// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:irrigazione_iot/src/utils/int_converter.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:irrigazione_iot/src/features/specie/models/specie_database_keys.dart';

part 'specie.g.dart';

@JsonSerializable()
class Specie extends Equatable {
  const Specie({
    required this.id,
    required this.name,
    this.createdAt,
  });

  @JsonKey(name: SpecieDatabaseKeys.id)
  @IntConverter()
  final String id;

  @JsonKey(name: SpecieDatabaseKeys.name)
  final String name;

  @JsonKey(name: SpecieDatabaseKeys.createdAt)
  final DateTime? createdAt;

  @override
  List<Object?> get props => [id, name, createdAt];

  factory Specie.fromJson(Map<String, dynamic> json) => _$SpecieFromJson(json);

  Map<String, dynamic> toJson() => _$SpecieToJson(this);
}
