// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:irrigazione_iot/src/features/sectors/model/available_sector_database_keys.dart';
import 'package:irrigazione_iot/src/utils/int_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'available_sector.g.dart';

@JsonSerializable()
class AvailableSector extends Equatable {
  const AvailableSector({
    required this.id,
    required this.sectorId,
    required this.companyId,
  });

  @JsonKey(name: AvailableSectorDatabaseKeys.id, includeToJson: false)
  @IntConverter()
  final String id;

  @JsonKey(name: AvailableSectorDatabaseKeys.sectorId)
  @IntConverter()
  final String sectorId;

  @JsonKey(name: AvailableSectorDatabaseKeys.companyId)
  @IntConverter()
  final String companyId;

  @override
  List<Object> get props => [id, sectorId, companyId];

  factory AvailableSector.fromJson(Map<String, dynamic> json) =>
      _$AvailableSectorFromJson(json);

  Map<String, dynamic> toJson() => _$AvailableSectorToJson(this);
}
