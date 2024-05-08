// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:irrigazione_iot/src/features/company_users/models/company_database_keys.dart';
import 'package:irrigazione_iot/src/utils/int_converter.dart';

part 'company.g.dart';

// A representation of companies, i.e the companies who uses the app
@JsonSerializable()
class Company extends Equatable {
  const Company({
    required this.id,
    required this.name,
    required this.registeredOfficeAddress,
    required this.phoneNumber,
    required this.email,
    required this.imageUrl,
    required this.mqttTopicName,
    this.createdAt,
    this.updatedAt,
    this.vatNumber = '',
    this.fiscalCode = '',
  });


  const Company.empty()
      : id = '',
        name = '',
        registeredOfficeAddress = '',
        phoneNumber = '',
        email = '',
        imageUrl = '',
        mqttTopicName = '',
        createdAt = null,
        updatedAt = null,
        vatNumber = '',
        fiscalCode = '';

  // Unique identifier for the company from the database
  @JsonKey(name: CompanyDatabaseKeys.id, includeToJson: false)
  @IntConverter()
  final String id;

  @JsonKey(name: CompanyDatabaseKeys.name)
  final String name;

  @JsonKey(name: CompanyDatabaseKeys.registeredOfficeAddress)
  final String registeredOfficeAddress;

  @JsonKey(name: CompanyDatabaseKeys.phoneNumber)
  final String phoneNumber;

  @JsonKey(name: CompanyDatabaseKeys.email)
  final String email;

  @JsonKey(name: CompanyDatabaseKeys.imageUrl)
  final String imageUrl;

  @JsonKey(name: CompanyDatabaseKeys.createdAt)
  final DateTime? createdAt;

  @JsonKey(name: CompanyDatabaseKeys.updatedAt)
  final DateTime? updatedAt;

  @JsonKey(name: CompanyDatabaseKeys.piva)
  final String? vatNumber;

  @JsonKey(name: CompanyDatabaseKeys.cf)
  final String? fiscalCode;

  @JsonKey(name: CompanyDatabaseKeys.mqttTopicName)
  final String mqttTopicName;

  @override
  List<Object?> get props {
    return [
      id,
      name,
      registeredOfficeAddress,
      phoneNumber,
      email,
      imageUrl,
      vatNumber,
      fiscalCode,
      createdAt,
      updatedAt,
      mqttTopicName
    ];
  }

  Company copyWith({
    String? id,
    String? name,
    String? registeredOfficeAddress,
    String? phoneNumber,
    String? email,
    String? imageUrl,
    String? vatNumber,
    String? fiscalCode,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? mqttTopicName,
  }) {
    return Company(
      id: id ?? this.id,
      name: name ?? this.name,
      mqttTopicName: mqttTopicName ?? this.mqttTopicName,
      registeredOfficeAddress:
          registeredOfficeAddress ?? this.registeredOfficeAddress,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      vatNumber: vatNumber ?? this.vatNumber,
      fiscalCode: fiscalCode ?? this.fiscalCode,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyToJson(this);
}
