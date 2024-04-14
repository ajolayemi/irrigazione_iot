// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector_database_keys.dart';
import 'package:json_annotation/json_annotation.dart';

part 'collector.g.dart';

@JsonSerializable()
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

  @JsonKey(name: CollectorDatabaseKeys.id)
  final String id;
  @JsonKey(name: CollectorDatabaseKeys.name)
  final String name;
  @JsonKey(name: CollectorDatabaseKeys.connectedFilterName)
  final String connectedFilterName;
  @JsonKey(name: CollectorDatabaseKeys.createdAt)
  final DateTime createdAt;
  @JsonKey(name: CollectorDatabaseKeys.updatedAt)
  final DateTime updatedAt;
  @JsonKey(name: CollectorDatabaseKeys.companyId)
  final String companyId;
  @JsonKey(name: CollectorDatabaseKeys.mqttMsgName)
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

  factory Collector.fromJson(Map<String, dynamic> json) =>
      _$CollectorFromJson(json);

  Map<String, dynamic> toJson() => _$CollectorToJson(this);
}
