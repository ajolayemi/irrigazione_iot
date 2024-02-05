import 'package:irrigazione_iot/src/config/enums/roles.dart';

typedef UserID = String;

class AppUser {
  final UserID uid;
  final String email;
  final String name;
  final String companyId; // TODO replace this with a CompanyID type
  final AppUserRoles role;

  const AppUser({
    required this.uid,
    required this.email,
    required this.name,
    required this.companyId,
    required this.role,
  });
  
  

  @override
  bool operator ==(covariant AppUser other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.email == email &&
      other.name == name &&
      other.companyId == companyId &&
      other.role == role;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      email.hashCode ^
      name.hashCode ^
      companyId.hashCode ^
      role.hashCode;
  }

  @override
  String toString() {
    return 'AppUser(uid: $uid, email: $email, name: $name, companyId: $companyId, role: $role)';
  }
}
