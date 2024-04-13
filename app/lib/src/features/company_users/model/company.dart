// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:irrigazione_iot/src/features/company_users/model/company_supabase_keys.dart';

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
      CompanySupabaseKeys.id: id,
      CompanySupabaseKeys.name: name,
      CompanySupabaseKeys.email: email,
      CompanySupabaseKeys.phoneNumber: phoneNumber,
      CompanySupabaseKeys.registeredOfficeAddress: registeredOfficeAddress,
      CompanySupabaseKeys.piva: vatNumber,
      CompanySupabaseKeys.cf: fiscalCode,
      CompanySupabaseKeys.imageUrl: imageUrl,
      CompanySupabaseKeys.createdAt: createdAt.toIso8601String(),
      CompanySupabaseKeys.updatedAt: updatedAt.toIso8601String(),
    };
  }

  static Company fromJson(Map<String, dynamic> json) {
    return Company(
      id: json[CompanySupabaseKeys.id] as String,
      name: json[CompanySupabaseKeys.name] as String,
      email: json[CompanySupabaseKeys.email] as String,
      phoneNumber: json[CompanySupabaseKeys.phoneNumber] as String,
      registeredOfficeAddress:
          json[CompanySupabaseKeys.registeredOfficeAddress] as String,
      vatNumber: json[CompanySupabaseKeys.piva] as String,
      fiscalCode: json[CompanySupabaseKeys.cf] as String,
      imageUrl: json[CompanySupabaseKeys.imageUrl] as String,
      createdAt: DateTime.parse(json[CompanySupabaseKeys.createdAt]),
      updatedAt: DateTime.parse(json[CompanySupabaseKeys.updatedAt]),
    );
  }
}
