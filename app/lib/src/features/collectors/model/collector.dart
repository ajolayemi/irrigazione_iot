// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector_supabase_keys.dart';

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
      CollectorSupabaseKeys.id: id,
      CollectorSupabaseKeys.name: name,
      CollectorSupabaseKeys.connectedFilterName: connectedFilterName,
      CollectorSupabaseKeys.createdAt: createdAt.toIso8601String(),
      CollectorSupabaseKeys.updatedAt: updatedAt.toIso8601String(),
      CollectorSupabaseKeys.companyId: companyId,
      CollectorSupabaseKeys.mqttMsgName: mqttMsgName,
    };
  }

  static Collector fromJson(Map<String, dynamic> json) {
    return Collector(
      id: json[CollectorSupabaseKeys.id] as String,
      name: json[CollectorSupabaseKeys.name] as String,
      connectedFilterName:
          json[CollectorSupabaseKeys.connectedFilterName] as String,
      createdAt:
          DateTime.parse(json[CollectorSupabaseKeys.createdAt] as String),
      updatedAt:
          DateTime.parse(json[CollectorSupabaseKeys.updatedAt] as String),
      companyId: json[CollectorSupabaseKeys.companyId] as String,
      mqttMsgName: json[CollectorSupabaseKeys.mqttMsgName] as String,
    );
  }
}
