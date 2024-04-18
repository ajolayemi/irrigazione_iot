import 'package:supabase_flutter/supabase_flutter.dart';

extension SupabaseClientExtensions on SupabaseClient {
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
