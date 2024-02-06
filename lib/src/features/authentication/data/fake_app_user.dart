// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/features/authentication/domain/app_user.dart';

/// Fake user class used to simulate a user account on the backend
/// * This class is implementation-specific and should only be used by the
/// * [FakeAuthRepository], so it should not belong to the domain layer
class FakeAppUser extends AppUser {
  const FakeAppUser({
    required super.uid,
    required super.email,
    required super.name,
    required super.companyId,
    required super.role,
    required super.surname,
    required this.password, 
  }); 
  final String password;

  @override
  FakeAppUser copyWith({
    String? uid,
    String? email,
    String? name,
    int? companyId,
    AppUserRoles? role,
    String? password,
    String? surname,
  }) {
    return FakeAppUser(
      uid: uid ?? super.uid,
      email: email ?? super.email,
      name: name ?? super.name,
      surname: surname ?? super.surname,
      companyId: companyId ?? super.companyId,
      role: role ?? super.role,
      password: password ?? this.password,
    );
  }

  @override
  bool operator ==(covariant FakeAppUser other) {
    if (identical(this, other)) return true;
  
    return 
      other.password == password;
  }

  @override
  int get hashCode => password.hashCode;
}
