// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';



/// A collector, by definition in this project, is made up of one or more sectors as represented by the
/// [CollectorSector] class. Each collector is assigned a "filtro" name, which serves as a global filtro for all sectors pertaining to this collector
class Collector extends Equatable {
  const Collector({
    required this.id,
    required this.name,
    required this.companyId,
    required this.filterName,
  });

  const Collector.empty()
      : id = '',
        name = '',
        companyId = '',
        filterName = '';

  // A unique identifier for this collector
  final String id;
  //
  final String name;
  final String companyId;

  // A global "filtro" name for all sectors pertaining to this collector
  final String filterName;

  @override
  List<Object> get props => [id, name, companyId, filterName];

  Collector copyWith({
    String? id,
    String? name,
    String? companyId,
    String? filterName,
  }) {
    return Collector(
      id: id ?? this.id,
      name: name ?? this.name,
      companyId: companyId ?? this.companyId,
      filterName: filterName ?? this.filterName,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'companyId': companyId,
      'filterName': filterName,
    };
  }

  factory Collector.fromJson(Map<String, dynamic> map) {
    return Collector(
      id: map['id'] as String,
      name: map['name'] as String,
      companyId: map['companyId'] as String,
      filterName: map['filterName'] as String,
    );
  }
}
