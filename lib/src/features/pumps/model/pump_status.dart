// ignore_for_file: public_member_api_docs, sort_constructors_first
// A representation of the status of a pump.

import 'package:equatable/equatable.dart';

import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';

class PumpStatus extends Equatable {
  const PumpStatus({
    required this.status,
    required this.lastUpdated,
    required this.pumpId,
  });
  final PumpID pumpId;
  // pump status are passed in as a string value because the status will be managed
  // using MQTT messages that sends and receives a string value
  // an internal logic will convert the string value to a boolean value when needed
  final String status;
  final DateTime lastUpdated;

  @override
  List<Object> get props => [pumpId, status, lastUpdated];

  @override
  bool get stringify => true;

  @override
  String toString() {
    return 'PumpStatus{pumpId: $pumpId, status: $status, lastUpdated: $lastUpdated}';
  }

  PumpStatus copyWith({
    PumpID? pumpId,
    String? status,
    DateTime? lastUpdated,
  }) {
    return PumpStatus(
      pumpId: pumpId ?? this.pumpId,
      status: status ?? this.status,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'pumpId': pumpId,
      'status': status,
      'lastUpdate': lastUpdated.millisecondsSinceEpoch,
    };
  }

  factory PumpStatus.fromJson(Map<String, dynamic> map) {
    return PumpStatus(
      pumpId: map['pumpId'] as PumpID,
      status: map['status'] as String,
      lastUpdated:
          DateTime.fromMillisecondsSinceEpoch(map['lastUpdate'] as int),
    );
  }
}

extension PumpStatusX on PumpStatus {
  bool translatePumpStatusToBoolean(Pump pump) => status == pump.commandForOn;
}
