// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector_database_keys.dart';

class Collector extends Equatable {
  const Collector({
    required this.id,
    required this.name,
    required this.connectedFilterName,
    required this.createdAt,
    required this.updatedAt,
    required this.companyId,
    required this.mqttMsgName,
  });

  Collector.empty()
      : id = '',
        name = '',
        connectedFilterName = '',
        createdAt = DateTime.parse('2024-01-01'),
        updatedAt = DateTime.parse('2024-01-01'),
        companyId = '',
        mqttMsgName = '';

  final String id;
  final String name;
  final String connectedFilterName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String companyId;
  final String mqttMsgName;

  @override
  List<Object> get props {
    return [
      id,
      name,
      connectedFilterName,
      createdAt,
      updatedAt,
      companyId,
      mqttMsgName,
    ];
  }

  Collector copyWith({
    String? id,
    String? name,
    String? connectedFilterName,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? companyId,
    String? mqttMsgName,
  }) {
    return Collector(
      id: id ?? this.id,
      name: name ?? this.name,
      connectedFilterName: connectedFilterName ?? this.connectedFilterName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      companyId: companyId ?? this.companyId,
      mqttMsgName: mqttMsgName ?? this.mqttMsgName,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      CollectorDatabaseKeys.id: id,
      CollectorDatabaseKeys.name: name,
      CollectorDatabaseKeys.connectedFilterName: connectedFilterName,
      CollectorDatabaseKeys.createdAt: createdAt.toIso8601String(),
      CollectorDatabaseKeys.updatedAt: updatedAt.toIso8601String(),
      CollectorDatabaseKeys.companyId: companyId,
      CollectorDatabaseKeys.mqttMsgName: mqttMsgName,
    };
  }

  static Collector fromJson(Map<String, dynamic> json) {
    return Collector(
      id: json[CollectorDatabaseKeys.id] as String,
      name: json[CollectorDatabaseKeys.name] as String,
      connectedFilterName:
          json[CollectorDatabaseKeys.connectedFilterName] as String,
      createdAt:
          DateTime.parse(json[CollectorDatabaseKeys.createdAt] as String),
      updatedAt:
          DateTime.parse(json[CollectorDatabaseKeys.updatedAt] as String),
      companyId: json[CollectorDatabaseKeys.companyId] as String,
      mqttMsgName: json[CollectorDatabaseKeys.mqttMsgName] as String,
    );
  }
}
