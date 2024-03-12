// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

typedef CompanyID = String;


// TODO check if this should be moved elsewhere
// A representation of companies, i.e the companies who uses the app
class Company extends Equatable {
  const Company(
      {required this.id,
      required this.name,
      required this.registeredOfficeAddress,
      required this.phoneNumber,
      required this.email,
      required this.imageUrl,
      this.vatNumber = '',
      this.fiscalCode = '',
});
  // Unique identifier for the company from the database
  final CompanyID id;
  final String name;
  final String registeredOfficeAddress;
  final String phoneNumber;
  final String email;
  final String imageUrl;
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
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'registeredOfficeAddress': registeredOfficeAddress,
      'phoneNumber': phoneNumber,
      'email': email,
      'imageUrl': imageUrl,
      'vatNumber': vatNumber,
      'fiscalCode': fiscalCode,
    };
  }

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      id: map['id'] as String,
      name: map['name'] as String,
      registeredOfficeAddress: map['registeredOfficeAddress'] as String,
      phoneNumber: map['phoneNumber'] as String,
      email: map['email'] as String,
      imageUrl: map['imageUrl'] as String,
      vatNumber: map['vatNumber'] != null ? map['vatNumber'] as String : null,
      fiscalCode:
          map['fiscalCode'] != null ? map['fiscalCode'] as String : null,
    );
  }

  @override
  bool get stringify => true;
}
