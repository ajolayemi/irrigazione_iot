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
      CompanySupabaseKeys.createdAt: createdAt.millisecondsSinceEpoch,
      CompanySupabaseKeys.updatedAt: updatedAt.millisecondsSinceEpoch,
    };
  }

  factory Company.fromJson(Map<String, dynamic> map) {
    return Company(
      id: map[CompanySupabaseKeys.id] as String,
      name: map[CompanySupabaseKeys.name] as String,
      email: map[CompanySupabaseKeys.email] as String,
      phoneNumber: map[CompanySupabaseKeys.phoneNumber] as String,
      registeredOfficeAddress:
          map[CompanySupabaseKeys.registeredOfficeAddress] as String,
      vatNumber: map[CompanySupabaseKeys.piva] as String,
      fiscalCode: map[CompanySupabaseKeys.cf] as String,
      imageUrl: map[CompanySupabaseKeys.imageUrl] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(
          map[CompanySupabaseKeys.createdAt] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(
          map[CompanySupabaseKeys.updatedAt] as int),
    );
  }
}
