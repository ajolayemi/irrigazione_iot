// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:irrigazione_iot/src/features/weather_stations/models/weather_station_database_keys.dart';
import 'package:irrigazione_iot/src/utils/int_converter.dart';

part 'weather_station.g.dart';

@JsonSerializable()
class WeatherStation extends Equatable {
  const WeatherStation({
    required this.id,
    required this.name,
    required this.eui,
    this.createdAt,
    this.updatedAt,
    required this.companyId,
    required this.sectorId,
  });

  const WeatherStation.empty()
      : id = '',
        name = '',
        eui = '',
        createdAt = null,
        updatedAt = null,
        companyId = '',
        sectorId = '';

  @JsonKey(name: WeatherStationDatabaseKeys.id, includeToJson: false)
  @IntConverter()
  final String id;

  @JsonKey(name: WeatherStationDatabaseKeys.name)
  final String name;

  @JsonKey(name: WeatherStationDatabaseKeys.eui)
  final String eui;

  @JsonKey(name: WeatherStationDatabaseKeys.createdAt)
  final DateTime? createdAt;

  @JsonKey(name: WeatherStationDatabaseKeys.updatedAt)
  final DateTime? updatedAt;

  @JsonKey(name: WeatherStationDatabaseKeys.companyId)
  @IntConverter()
  final String companyId;

  @JsonKey(name: WeatherStationDatabaseKeys.sectorId)
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

  factory WeatherStation.fromJson(Map<String, dynamic> json) =>
      _$WeatherStationFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherStationToJson(this);

  WeatherStation copyWith({
    String? id,
    String? name,
    String? eui,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? companyId,
    String? sectorId,
  }) {
    return WeatherStation(
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
