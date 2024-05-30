import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/variety/data/variety_repository.dart';
import 'package:irrigazione_iot/src/features/variety/models/variety.dart';
import 'package:irrigazione_iot/src/features/variety/models/variety_database_keys.dart';
import 'package:irrigazione_iot/src/utils/extensions/supabase_extensions.dart';

class SupabaseVarietyRepository implements VarietyRepository {
  const SupabaseVarietyRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  List<Variety>? _varietiesFromJson(List<Map<String, dynamic>>? json) {
    if (json == null) return null;
    return json.map((e) => Variety.fromJson(e)).toList();
  }

  Variety? _varietySingleFromJsonList(List<Map<String, dynamic>>? json) =>
      json?.map((e) => Variety.fromJson(e)).first;

  Variety? _toVariety(Map<String, dynamic>? json) =>
      json == null ? null : Variety.fromJson(json);

  @override
  Stream<List<Variety>?> watchVarieties() => _supabaseClient.varieties
      .stream(primaryKey: [VarietyDatabaseKeys.id])
      .order(VarietyDatabaseKeys.name, ascending: true)
      .map((data) => _varietiesFromJson(data));

  @override
  Stream<Variety?> watchVariety(String varietyId) => _supabaseClient.varieties
      .stream(primaryKey: [VarietyDatabaseKeys.id])
      .eq(VarietyDatabaseKeys.id, varietyId)
      .limit(1)
      .map(_varietySingleFromJsonList);

  @override
  Future<Variety?> getVariety(String varietyId) async {
    final data = await _supabaseClient.varieties
        .select()
        .eq(VarietyDatabaseKeys.id, varietyId)
        .maybeSingle()
        .withConverter(_toVariety);
    return data;
  }

  @override
  Future<List<Variety>?> getVarieties() async {
    final data = await _supabaseClient.varieties
        .select()
        .order(VarietyDatabaseKeys.name, ascending: true)
        .withConverter(_varietiesFromJson);
    return data;
  }
}
