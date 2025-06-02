// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:irrigazione_iot/src/data/datasource/entities/mqtt_entities.dart';
import 'package:irrigazione_iot/src/features/dashboard/models/pump_switched_on_database_keys.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump_status.dart';
import 'package:irrigazione_iot/src/utils/int_converter.dart';

part 'pump_switched_on.g.dart';

@JsonSerializable()

/// A model representation of pumps currently switched on.
class PumpSwitchedOn extends Equatable {
  const PumpSwitchedOn({
    required this.id,
    required this.statusBoolean,
    required this.pumpId,
    required this.companyId,
  });

  @JsonKey(name: 'id')
  @IntConverter()
  final String id;

  @JsonKey(name: PumpSwitchedOnDatabaseKeys.statusBoolean)
  final bool statusBoolean;

  @JsonKey(name: PumpSwitchedOnDatabaseKeys.pumpId)
  @IntConverter()
  final String pumpId;

  @JsonKey(name: PumpSwitchedOnDatabaseKeys.companyId)
  @IntConverter()
  final String companyId;

  @override
  List<Object> get props {
    return [
      id,
      statusBoolean,
      pumpId,
      companyId,
    ];
  }

  factory PumpSwitchedOn.fromJson(Map<String, dynamic> json) =>
      _$PumpSwitchedOnFromJson(json);

  Map<String, dynamic> toJson() => _$PumpSwitchedOnToJson(this);

  factory PumpSwitchedOn.fromEntity(LocalPumpSwitchedOn? entity) {
    return PumpSwitchedOn(
      companyId: entity?.item?.companyId ?? '',
      id: entity?.id.toString() ?? '',
      pumpId: entity?.id.toString() ?? '',
      statusBoolean: entity?.item?.statusBoolean ?? false,
    );
  }

  factory PumpSwitchedOn.fromPumpStatus(PumpStatus? status) {
    return PumpSwitchedOn(
      companyId: status?.companyId ?? '',
      id: status?.pumpId ?? '',
      pumpId: status?.pumpId ?? '',
      statusBoolean: status?.statusBoolean ?? false,
    );
  }

  LocalPumpSwitchedOn toEntity() {
    final item = LocalItemSwitchedOn()
      ..companyId = companyId
      ..statusBoolean = statusBoolean;
    return LocalPumpSwitchedOn()
      ..id = int.tryParse(pumpId)
      ..item = item;
  }
}

extension PumpsSwitchedOn on List<PumpSwitchedOn> {
  List<LocalPumpSwitchedOn> toEntities() {
    return map((e) => e.toEntity()).toList();
  }
}
