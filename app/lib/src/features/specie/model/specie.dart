// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class Specie extends Equatable {
  const Specie({
    required this.id,
    required this.name,
    this.variety
  });

  final String id;
  final String name;
  final String? variety;

  @override
  List<Object?> get props => [id, name, variety];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'variety': variety,
    };
  }

  factory Specie.fromJson(Map<String, dynamic> map) {
    return Specie(
      id: map['id'] as String,
      name: map['name'] as String,
      variety: map['variety'] as String,
    );
  }
}
