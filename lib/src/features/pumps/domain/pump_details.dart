// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:irrigazione_iot/src/features/pumps/domain/pump.dart';

class PumpDetails extends Pump {
  const PumpDetails({
    required super.id,
    required super.name,
    required super.capacityInVolume,
    required super.consumeRateInKw,
    required super.commandForOn,
    required super.commandForOff,
    required super.companyId,
    required this.totalLitresDispensed,
  });

  const PumpDetails.empty()
      : totalLitresDispensed = 0,
        super.empty();

  final int totalLitresDispensed;

  @override
  bool operator ==(covariant PumpDetails other) {
    if (identical(this, other)) return true;

    return other.totalLitresDispensed == totalLitresDispensed;
  }

  @override
  int get hashCode => totalLitresDispensed.hashCode;

  @override
  String toString() =>
      'PumpDetails(totalLitresDispensed: $totalLitresDispensed)';
}

// class PumpDetails extends Equatable {
//   const PumpDetails({
//     required this.pump,
//     required this.totalLitresDispensed,
//   });

//   final Pump pump;
//   final int totalLitresDispensed;

//   @override
//   List<Object> get props => [pump, totalLitresDispensed];

//   Map<String, dynamic> toJson() {
//     return <String, dynamic>{
//       'pump': pump.toMap(),
//       'totalLitresDispensed': totalLitresDispensed,
//       'lastDispensation': lastDispensation.millisecondsSinceEpoch,
//     };
//   }

//   factory PumpDetails.fromJson(Map<String, dynamic> map) {
//     return PumpDetails(
//       pump: Pump.fromMap(map['pump'] as Map<String, dynamic>),
//       totalLitresDispensed: map['totalLitresDispensed'] as int,
//       lastDispensation:
//           DateTime.fromMillisecondsSinceEpoch(map['lastDispensation'] as int),
//     );
//   }

//   @override
//   bool get stringify => true;
// }
