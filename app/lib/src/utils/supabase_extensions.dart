import 'package:irrigazione_iot/src/features/pumps/model/pump_flow_database_keys.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/company_users/model/company_database_keys.dart';
import 'package:irrigazione_iot/src/features/company_users/model/company_user_database_keys.dart';

extension SupabaseClientExtensions on SupabaseClient {
  SupabaseQueryBuilder get companies => from(CompanyDatabaseKeys.table);

  PostgrestFilterBuilder get selectedCompanies => companies.select();

  SupabaseQueryBuilder get companyUsers => from(CompanyUserDatabaseKeys.table);

  SupabaseQueryBuilder get pumpFlow => from(PumpFlowDatabaseKeys.table);

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

extension FunctionResponseExtensions on FunctionResponse {
  T? toObject<T>(T Function(Map<String, dynamic>) fromJson) {
    final data = this.data as Map<String, dynamic>?;

    if (data != null) {
      return fromJson(data);
    }

    return null;
  }

  bool get onDelete => status == 200 || status == 204;
}
