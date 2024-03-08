// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:irrigazione_iot/src/features/sectors/model/sector.dart';

class SectorStatus extends Equatable {
  const SectorStatus(
      {required this.sectorId, required this.status, required this.when});

  final SectorID sectorId;
  // sector status are passed in as a string value because the status will be managed
  // using MQTT messages that sends and receives a string value
  // an internal logic will convert the string value to a boolean value when needed
  final String status;

  final DateTime when;

  @override
  List<Object> get props => [sectorId, status, when];

  SectorStatus copyWith({
    SectorID? sectorId,
    String? status,
    DateTime? when,
  }) {
    return SectorStatus(
      sectorId: sectorId ?? this.sectorId,
      status: status ?? this.status,
      when: when ?? this.when,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sectorId': sectorId,
      'status': status,
      'when': when.millisecondsSinceEpoch,
    };
  }

  factory SectorStatus.fromMap(Map<String, dynamic> map) {
    return SectorStatus(
      sectorId: map['sectorId'] as SectorID,
      status: map['status'] as String,
      when: DateTime.fromMillisecondsSinceEpoch(map['when'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory SectorStatus.fromJson(String source) =>
      SectorStatus.fromMap(json.decode(source) as Map<String, dynamic>);
}

extension SectorStatusX on SectorStatus {
  bool translateSectorStatusToBoolean(Sector sector) {
    return status == sector.turnOnCommand;
  }
}
