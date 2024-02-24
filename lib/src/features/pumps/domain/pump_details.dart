// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

import 'package:irrigazione_iot/src/features/pumps/domain/pump.dart';

class PumpDetails extends Equatable {
  const PumpDetails({
    required this.pump,
    required this.totalLitresDispensed,
    required this.lastDispensation,
  });
  
  final Pump pump;
  final int totalLitresDispensed;
  final DateTime lastDispensation;


  @override
  List<Object> get props => [pump, totalLitresDispensed, lastDispensation];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'pump': pump.toMap(),
      'totalLitresDispensed': totalLitresDispensed,
      'lastDispensation': lastDispensation.millisecondsSinceEpoch,
    };
  }

  factory PumpDetails.fromJson(Map<String, dynamic> map) {
    return PumpDetails(
      pump: Pump.fromMap(map['pump'] as Map<String,dynamic>),
      totalLitresDispensed: map['totalLitresDispensed'] as int,
      lastDispensation: DateTime.fromMillisecondsSinceEpoch(map['lastDispensation'] as int),
    );
  }

  @override
  bool get stringify => true;
}
