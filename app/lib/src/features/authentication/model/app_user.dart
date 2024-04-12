// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

typedef UserID = String;

class AppUser extends Equatable {
  const AppUser({
    required this.uid,
    required this.email,
    required this.name,
    required this.surname,
  });

  final UserID uid;
  final String email;
  final String name;
  final String surname;

  @override
  List<Object> get props => [uid, email, name, surname];

  AppUser copyWith({
    UserID? uid,
    String? email,
    String? name,
    String? surname,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      surname: surname ?? this.surname,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'name': name,
      'surname': surname,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'] as UserID,
      email: map['email'] as String,
      name: map['name'] as String,
      surname: map['surname'] as String,
    );
  }
}

extension AppUserExtensions on AppUser {
  String get fullName => '$name $surname';
}
