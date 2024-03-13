// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:equatable/equatable.dart';

import 'package:irrigazione_iot/src/features/collectors/model/collector.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector.dart';

/// A representation of a [Sector] in a [Collector]
class CollectorSector extends Equatable {
  
  const CollectorSector({
    required this.collectorId,
    required this.sectorId,
  });
  final CollectorID collectorId;
  final SectorID sectorId;

  @override
  List<Object> get props => [collectorId, sectorId];

  CollectorSector copyWith({
    CollectorID? collectorId,
    SectorID? sectorId,
  }) {
    return CollectorSector(
      collectorId: collectorId ?? this.collectorId,
      sectorId: sectorId ?? this.sectorId,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'collectorId': collectorId,
      'sectorId': sectorId
    };
  }

  factory CollectorSector.fromJson(Map<String, dynamic> map) {
    return CollectorSector(
      collectorId: map['collectorId'] as CollectorID,
      sectorId: map['sectorId'] as SectorID,
    );
  }
}
