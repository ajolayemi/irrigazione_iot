import 'package:equatable/equatable.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board_database_keys.dart';

class Board extends Equatable {
  const Board({
    required this.id,
    required this.name,
    required this.model,
    required this.serialNumber,
    required this.collectorId,
    required this.companyId,
    required this.createdAt,
    required this.updatedAt,
    required this.mqttMsgName,
  });

  Board.empty()
      : id = '',
        name = '',
        model = '',
        serialNumber = '',
        collectorId = '',
        companyId = '',
        createdAt = DateTime.parse('2024-01-01'),
        updatedAt = DateTime.parse('2024-01-01'),
        mqttMsgName = '';

  final String id;
  final String name;
  final String model;
  final String serialNumber;
  final String collectorId;
  final String companyId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String mqttMsgName;

  @override
  List<Object> get props {
    return [
      id,
      name,
      model,
      serialNumber,
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
    String? serialNumber,
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
      serialNumber: serialNumber ?? this.serialNumber,
      collectorId: collectorId ?? this.collectorId,
      companyId: companyId ?? this.companyId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      mqttMsgName: mqttMsgName ?? this.mqttMsgName,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      BoardDatabaseKeys.id: id,
      BoardDatabaseKeys.name: name,
      BoardDatabaseKeys.model: model,
      BoardDatabaseKeys.serialNumber: serialNumber,
      BoardDatabaseKeys.collectorId: collectorId,
      BoardDatabaseKeys.companyId: companyId,
      BoardDatabaseKeys.createdAt: createdAt.toIso8601String(),
      BoardDatabaseKeys.updatedAt: updatedAt.toIso8601String(),
      BoardDatabaseKeys.mqttMsgName: mqttMsgName,
    };
  }

  static Board fromJson(Map<String, dynamic> json) {
    return Board(
      id: json[BoardDatabaseKeys.id] as String,
      name: json[BoardDatabaseKeys.name] as String,
      model: json[BoardDatabaseKeys.model] as String,
      serialNumber: json[BoardDatabaseKeys.serialNumber] as String,
      collectorId: json[BoardDatabaseKeys.collectorId] as String,
      companyId: json[BoardDatabaseKeys.companyId] as String,
      createdAt: DateTime.parse(json[BoardDatabaseKeys.createdAt] as String),
      updatedAt: DateTime.parse(json[BoardDatabaseKeys.updatedAt] as String),
      mqttMsgName: json[BoardDatabaseKeys.mqttMsgName] as String,
    );
  }
}
