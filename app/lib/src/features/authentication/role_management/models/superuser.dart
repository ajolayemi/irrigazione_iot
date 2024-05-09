// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:irrigazione_iot/src/features/authentication/role_management/models/superuser_database_keys.dart';
import 'package:irrigazione_iot/src/utils/int_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'superuser.g.dart';

@JsonSerializable()
class SuperUser extends Equatable {
  const SuperUser({
    required this.id,
    required this.email,
    this.createdAt,
  });

  @IntConverter()
  final String id;

  final String email;

  @JsonKey(name: SuperuserDatabaseKeys.createdAt)
  final DateTime? createdAt;

  @override
  List<Object?> get props => [id, email, createdAt];

  factory SuperUser.fromJson(Map<String, dynamic> json) =>
      _$SuperUserFromJson(json);

  Map<String, dynamic> toJson() => _$SuperUserToJson(this);
}
