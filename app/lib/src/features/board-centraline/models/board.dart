// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

/// A representation of a board. (centraline)
class Board extends Equatable {
  const Board({
    required this.id,
    required this.name,
    required this.model,
    required this.serialNumber,
    required this.collectorId,
    required this.companyId,
  });

  const Board.empty()
      : id = '',
        name = '',
        model = '',
        serialNumber = '',
        collectorId = '',
        companyId = '';

  final String id;
  final String name;
  final String model;
  final String serialNumber;

  /// Each board is associated with a collector.
  final String collectorId;
  final String companyId;

  @override
  List<Object> get props {
    return [
      id,
      name,
      model,
      serialNumber,
      collectorId,
      companyId,
    ];
  }

  Board copyWith({
    String? id,
    String? name,
    String? model,
    String? serialNumber,
    String? collectorId,
    String? companyId,
  }) {
    return Board(
      id: id ?? this.id,
      name: name ?? this.name,
      model: model ?? this.model,
      serialNumber: serialNumber ?? this.serialNumber,
      collectorId: collectorId ?? this.collectorId,
      companyId: companyId ?? this.companyId,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'model': model,
      'serialNumber': serialNumber,
      'collectorId': collectorId,
      'companyId': companyId,
    };
  }

  factory Board.fromJson(Map<String, dynamic> map) {
    return Board(
      id: map['id'] as String,
      name: map['name'] as String,
      model: map['model'] as String,
      serialNumber: map['serialNumber'] as String,
      collectorId: map['collectorId'] as String,
      companyId: map['companyId'] as String,
    );
  }
}
