import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/variety/data/variety_repository.dart';
import 'package:irrigazione_iot/src/features/variety/model/variety.dart';
import 'package:irrigazione_iot/src/features/variety/model/variety_database_keys.dart';
import 'package:irrigazione_iot/src/utils/supabase_extensions.dart';

class SupabaseVarietyRepository implements VarietyRepository {
  const SupabaseVarietyRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  List<Variety> _varietiesFromJson(List<Map<String, dynamic>> json) {
    return json.map((e) => Variety.fromJson(e)).toList();
  }

  @override
  Stream<List<Variety>?> watchVarieties() => _supabaseClient.varieties
      .stream(primaryKey: [VarietyDatabaseKeys.id]).map(_varietiesFromJson);
}
