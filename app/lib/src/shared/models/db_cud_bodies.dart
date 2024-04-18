import 'package:json_annotation/json_annotation.dart';

part 'db_cud_bodies.g.dart';

@JsonSerializable()
class InsertBody {
  const InsertBody({required this.data});

  final Map<String, dynamic> data;

  factory InsertBody.fromJson(Map<String, dynamic> json) =>
      _$InsertBodyFromJson(json);

  Map<String, dynamic> toJson() => _$InsertBodyToJson(this);
}

@JsonSerializable()
class UpdateBody {
  const UpdateBody({required this.id, required this.data});

  final String id;
  final Map<String, dynamic> data;

  factory UpdateBody.fromJson(Map<String, dynamic> json) =>
      _$UpdateBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateBodyToJson(this);
}

@JsonSerializable()
class DeleteBody {
  const DeleteBody({required this.ids});

  final List<String> ids;

  factory DeleteBody.fromJson(Map<String, dynamic> json) =>
      _$DeleteBodyFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteBodyToJson(this);
}