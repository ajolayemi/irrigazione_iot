// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:irrigazione_iot/src/features/weather_stations/models/sensor_database_keys.dart';
import 'package:irrigazione_iot/src/utils/int_converter.dart';

part 'sensor.g.dart';


// TODO: tipologia (pressione, )

// TODO: rename to StazioneMeteo (SenseCap data)
@JsonSerializable()
class Sensor extends Equatable {
  const Sensor({
    required this.id,
    required this.name,
    required this.eui,
    this.createdAt,
    this.updatedAt,
    required this.companyId,
    required this.sectorId,
  });

  const Sensor.empty()
      : id = '',
        name = '',
        eui = '',
        createdAt = null,
        updatedAt = null,
        companyId = '',
        sectorId = '';

  @JsonKey(name: SensorDatabaseKeys.id, includeToJson: false)
  @IntConverter()
  final String id;

  @JsonKey(name: SensorDatabaseKeys.name)
  final String name;

  @JsonKey(name: SensorDatabaseKeys.eui)
  final String eui;

  @JsonKey(name: SensorDatabaseKeys.createdAt)
  final DateTime? createdAt;

  @JsonKey(name: SensorDatabaseKeys.updatedAt)
  final DateTime? updatedAt;

  @JsonKey(name: SensorDatabaseKeys.companyId)
  @IntConverter()
  final String companyId;

  @JsonKey(name: SensorDatabaseKeys.sectorId)
  @IntConverter()
  final String sectorId;

  @override
  List<Object?> get props {
    return [
      id,
      name,
      eui,
      createdAt,
      updatedAt,
      companyId,
      sectorId,
    ];
  }

  factory Sensor.fromJson(Map<String, dynamic> json) => _$SensorFromJson(json);

  Map<String, dynamic> toJson() => _$SensorToJson(this);

  Sensor copyWith({
    String? id,
    String? name,
    String? eui,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? companyId,
    String? sectorId,
  }) {
    return Sensor(
      id: id ?? this.id,
      name: name ?? this.name,
      eui: eui ?? this.eui,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      companyId: companyId ?? this.companyId,
      sectorId: sectorId ?? this.sectorId,
    );
  }
}
