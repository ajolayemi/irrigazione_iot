import 'package:irrigazione_iot/src/features/company_users/model/company_database_keys.dart';
import 'package:irrigazione_iot/src/features/company_users/model/company_user_database_keys.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

extension SupabaseClientExtensions on SupabaseClient {
  SupabaseQueryBuilder get companies => from(CompanyDatabaseKeys.table);

  SupabaseQueryBuilder get companyUsers => from(CompanyUserDatabaseKeys.table);

  /// Getter for the current access token
  String? get accessToken => auth.currentSession?.accessToken;

  /// Invokes a function with the provided [functionName] and [body]
  Future<FunctionResponse> invokeFunction({
    required String functionName,
    required Map<String, dynamic> body,
  }) =>
      functions.invoke(
        functionName,
        body: body,
        headers: {'Authorization': 'Bearer $accessToken'},
      );
}
