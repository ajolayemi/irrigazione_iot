// ignore_for_file: public_member_api_docs, sort_constructors_first

typedef UserID = String;

class AppUser {
  final UserID uid;
  final String email;
  final String name;
  final String surname;

  const AppUser({
    required this.uid,
    required this.email,
    required this.name,
    required this.surname,
  });

  @override
  bool operator ==(covariant AppUser other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.email == email &&
        other.name == name &&
        other.surname == surname;
  }

  @override
  int get hashCode {
    return uid.hashCode ^ email.hashCode ^ name.hashCode ^ surname.hashCode;
  }

  @override
  String toString() {
    return 'AppUser(uid: $uid, email: $email, name: $name, surname: $surname)';
  }

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
      uid: map['uid'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      surname: map['surname'] as String,
 
    );
  }
}
