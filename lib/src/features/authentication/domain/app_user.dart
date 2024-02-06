// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:irrigazione_iot/src/config/enums/roles.dart';

typedef UserID = String;

class AppUser {
  final UserID uid;
  final String email;
  final String name;
  final String surname;
  final int companyId; // TODO replace this with a CompanyID type
  final AppUserRoles role;

  const AppUser({
    required this.uid,
    required this.email,
    required this.name,
    required this.companyId,
    required this.role,
    required this.surname,
  });



  @override
  bool operator ==(covariant AppUser other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.email == email &&
      other.name == name &&
      other.surname == surname &&
      other.companyId == companyId &&
      other.role == role;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      email.hashCode ^
      name.hashCode ^
      surname.hashCode ^
      companyId.hashCode ^
      role.hashCode;
  }

  @override
  String toString() {
    return 'AppUser(uid: $uid, email: $email, name: $name, surname: $surname, companyId: $companyId, role: $role)';
  }

  AppUser copyWith({
    UserID? uid,
    String? email,
    String? name,
    String? surname,
    int? companyId,
    AppUserRoles? role,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      companyId: companyId ?? this.companyId,
      role: role ?? this.role,
    );
  }
}
