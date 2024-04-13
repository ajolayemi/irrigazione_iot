// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector.dart';

/// A representation of a [Sector] in a [Collector]
class CollectorSector extends Equatable {
  const CollectorSector({
    required this.collectorId,
    required this.sectorId,
    required this.companyId,
  });

  const CollectorSector.empty()
      : collectorId = '',
        sectorId = '',
        companyId = '';
  final CollectorID collectorId;
  final String sectorId;
  final String companyId;

  @override
  List<Object> get props => [collectorId, sectorId, companyId];

  CollectorSector copyWith({
    CollectorID? collectorId,
    String? sectorId,
    String? companyId,
  }) {
    return CollectorSector(
      collectorId: collectorId ?? this.collectorId,
      sectorId: sectorId ?? this.sectorId,
      companyId: companyId ?? this.companyId,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'collectorId': collectorId,
      'sectorId': sectorId,
      'companyId': companyId
    };
  }

  factory CollectorSector.fromJson(Map<String, dynamic> map) {
    return CollectorSector(
      collectorId: map['collectorId'] as CollectorID,
      sectorId: map['sectorId'] as String,
      companyId: map['companyId'] as String,
    );
  }
}
