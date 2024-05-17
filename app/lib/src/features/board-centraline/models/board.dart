import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:irrigazione_iot/src/features/board-centraline/models/board_database_keys.dart';
import 'package:irrigazione_iot/src/utils/int_converter.dart';

part 'board.g.dart';

@JsonSerializable()
class Board extends Equatable {
  const Board({
    required this.id,
    required this.name,
    required this.model,
    required this.eui,
    required this.collectorId,
    required this.companyId,
    required this.mqttMsgName,
    this.createdAt,
    this.updatedAt,
  });

  const Board.empty()
      : id = '',
        name = '',
        model = '',
        eui = '',
        collectorId = '',
        companyId = '',
        createdAt = null,
        updatedAt = null,
        mqttMsgName = '';

  @JsonKey(name: BoardDatabaseKeys.id, includeToJson: false)
  @IntConverter()
  final String id;

  @JsonKey(name: BoardDatabaseKeys.name)
  final String name;

  @JsonKey(name: BoardDatabaseKeys.model)
  final String model;

  @JsonKey(name: BoardDatabaseKeys.eui)
  final String eui;

  @JsonKey(name: BoardDatabaseKeys.collectorId)
  @IntConverter()
  final String collectorId;

  @JsonKey(name: BoardDatabaseKeys.companyId)
  @IntConverter()
  final String companyId;

  @JsonKey(name: BoardDatabaseKeys.createdAt)
  final DateTime? createdAt;

  @JsonKey(name: BoardDatabaseKeys.updatedAt)
  final DateTime? updatedAt;

  @JsonKey(name: BoardDatabaseKeys.mqttMsgName)
  final String mqttMsgName;

  @override
  List<Object?> get props {
    return [
      id,
      name,
      model,
      eui,
      collectorId,
      companyId,
      createdAt,
      updatedAt,
      mqttMsgName,
    ];
  }

  Board copyWith({
    String? id,
    String? name,
    String? model,
    String? eui,
    String? collectorId,
    String? companyId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? mqttMsgName,
  }) {
    return Board(
      id: id ?? this.id,
      name: name ?? this.name,
      model: model ?? this.model,
      eui: eui ?? this.eui,
      collectorId: collectorId ?? this.collectorId,
      companyId: companyId ?? this.companyId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      mqttMsgName: mqttMsgName ?? this.mqttMsgName,
    );
  }

  factory Board.fromJson(Map<String, dynamic> json) => _$BoardFromJson(json);

  Map<String, dynamic> toJson() => _$BoardToJson(this);
}
