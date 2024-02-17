// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:irrigazione_iot/src/config/enums/roles.dart';

typedef UserID = String;

class AppUser {
  final UserID uid;
  final String email;
  final String name;
  final String surname; 
  final AppUserRoles role;

  const AppUser({
    required this.uid,
    required this.email,
    required this.name,
    required this.role,
    required this.surname,
  });

  @override
  bool operator ==(covariant AppUser other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.email == email &&
        other.name == name &&
        other.surname == surname &&
        other.role == role;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        email.hashCode ^
        name.hashCode ^
        surname.hashCode ^
        role.hashCode;
  }

  @override
  String toString() {
    return 'AppUser(uid: $uid, email: $email, name: $name, surname: $surname,  role: $role)';
  }

  AppUser copyWith({
    UserID? uid,
    String? email,
    String? name,
    String? surname,
    AppUserRoles? role,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'name': name,
      'surname': surname,
      'role': role,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      surname: map['surname'] as String,
      role: AppUserRoles.values.firstWhere(
        (role) => role.toString() == map['role'] as String,
      ),
    );
  }

}
