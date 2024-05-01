// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:irrigazione_iot/src/features/collectors/model/collector_database_keys.dart';
import 'package:irrigazione_iot/src/utils/int_converter.dart';

part 'collector.g.dart';

@JsonSerializable()
class Collector extends Equatable {
  const Collector({
    required this.id,
    required this.name,
    required this.companyId,
    required this.mqttMsgName,
    required this.hasFilter,
    this.createdAt,
    this.updatedAt,
  });

  const Collector.empty()
      : id = '',
        name = '',
        hasFilter = false,
        createdAt = null,
        updatedAt = null,
        companyId = '',
        mqttMsgName = '';

  @JsonKey(name: CollectorDatabaseKeys.id, includeToJson: false)
  @IntConverter()
  final String id;

  @JsonKey(name: CollectorDatabaseKeys.name)
  final String name;

  @JsonKey(name: CollectorDatabaseKeys.createdAt)
  final DateTime? createdAt;

  @JsonKey(name: CollectorDatabaseKeys.updatedAt)
  final DateTime? updatedAt;

  @JsonKey(name: CollectorDatabaseKeys.companyId)
  @IntConverter()
  final String companyId;

  @JsonKey(name: CollectorDatabaseKeys.mqttMsgName)
  final String mqttMsgName;

  @JsonKey(name: CollectorDatabaseKeys.hasFilter)
  final bool hasFilter;

  @override
  List<Object?> get props {
    return [
      id,
      name,
      createdAt,
      updatedAt,
      companyId,
      mqttMsgName,
    ];
  }

  factory Collector.fromJson(Map<String, dynamic> json) =>
      _$CollectorFromJson(json);

  Map<String, dynamic> toJson() => _$CollectorToJson(this);

  Collector copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? companyId,
    String? mqttMsgName,
    bool? hasFilter,
  }) {
    return Collector(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      companyId: companyId ?? this.companyId,
      mqttMsgName: mqttMsgName ?? this.mqttMsgName,
      hasFilter: hasFilter ?? this.hasFilter,
    );
  }
}
