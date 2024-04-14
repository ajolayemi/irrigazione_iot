// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:irrigazione_iot/src/features/company_users/model/company_database_keys.dart';

// A representation of companies, i.e the companies who uses the app
class Company extends Equatable {
  const Company({
    required this.id,
    required this.name,
    required this.registeredOfficeAddress,
    required this.phoneNumber,
    required this.email,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    this.vatNumber = '',
    this.fiscalCode = '',
  });

  // Unique identifier for the company from the database
  final String id;
  final String name;
  final String registeredOfficeAddress;
  final String phoneNumber;
  final String email;
  final String imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? vatNumber;
  final String? fiscalCode;

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
  }) {
    return Company(
      id: id ?? this.id,
      name: name ?? this.name,
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

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      CompanyDatabaseKeys.id: id,
      CompanyDatabaseKeys.name: name,
      CompanyDatabaseKeys.email: email,
      CompanyDatabaseKeys.phoneNumber: phoneNumber,
      CompanyDatabaseKeys.registeredOfficeAddress: registeredOfficeAddress,
      CompanyDatabaseKeys.piva: vatNumber,
      CompanyDatabaseKeys.cf: fiscalCode,
      CompanyDatabaseKeys.imageUrl: imageUrl,
      CompanyDatabaseKeys.createdAt: createdAt.toIso8601String(),
      CompanyDatabaseKeys.updatedAt: updatedAt.toIso8601String(),
    };
  }

  static Company fromJson(Map<String, dynamic> json) {
    return Company(
      id: json[CompanyDatabaseKeys.id] as String,
      name: json[CompanyDatabaseKeys.name] as String,
      email: json[CompanyDatabaseKeys.email] as String,
      phoneNumber: json[CompanyDatabaseKeys.phoneNumber] as String,
      registeredOfficeAddress:
          json[CompanyDatabaseKeys.registeredOfficeAddress] as String,
      vatNumber: json[CompanyDatabaseKeys.piva] as String,
      fiscalCode: json[CompanyDatabaseKeys.cf] as String,
      imageUrl: json[CompanyDatabaseKeys.imageUrl] as String,
      createdAt: DateTime.parse(json[CompanyDatabaseKeys.createdAt]),
      updatedAt: DateTime.parse(json[CompanyDatabaseKeys.updatedAt]),
    );
  }
}
