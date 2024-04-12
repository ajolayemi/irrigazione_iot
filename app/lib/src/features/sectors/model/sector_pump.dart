// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'sector.dart';

/// A representation of pumps that irrigate a sector.
class SectorPump extends Equatable {
  const SectorPump({
    required this.pumpId,
    required this.sectorId,
  });

  final String pumpId;
  final SectorID sectorId;

  @override
  List<Object> get props => [pumpId, sectorId];

  SectorPump copyWith({
    String? pumpId,
    SectorID? sectorId,
  }) {
    return SectorPump(
      pumpId: pumpId ?? this.pumpId,
      sectorId: sectorId ?? this.sectorId,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'pumpId': pumpId,
      'sectorId': sectorId,
    };
  }

  factory SectorPump.fromJson(Map<String, dynamic> map) {
    return SectorPump(
      pumpId: map['pumpId'] as String,
      sectorId: map['sectorId'] as SectorID,
    );
  }

  @override
  String toString() {
    return 'SectorPump(pumpId: $pumpId, sectorId: $sectorId)';
  }
}
