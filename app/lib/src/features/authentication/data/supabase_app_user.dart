import 'package:irrigazione_iot/src/features/authentication/model/app_user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Wrapper for the [User] class from Supabase
class SupabaseAppUser implements AppUser {
  const SupabaseAppUser(this._user);

  final User _user;

  @override
  String get email => _user.email ?? '';

  @override
  String get name => _user.userMetadata?['name'];

  @override
  String get surname => _user.userMetadata?['surname'];

  @override
  UserID get uid => _user.id;
}
