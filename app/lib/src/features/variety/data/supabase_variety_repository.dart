import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/variety/data/variety_repository.dart';
import 'package:irrigazione_iot/src/features/variety/model/variety.dart';
import 'package:irrigazione_iot/src/features/variety/model/variety_database_keys.dart';
import 'package:irrigazione_iot/src/utils/supabase_extensions.dart';

class SupabaseVarietyRepository implements VarietyRepository {
  const SupabaseVarietyRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  List<Variety>? _varietiesFromJson(
      List<Map<String, dynamic>>? json, String? selectedId) {
    if (json == null) return null;
    final varieties = json.map((e) => Variety.fromJson(e)).toList();
    final indexOfSelected =
        varieties.indexWhere((variety) => variety.id == selectedId);
    if (indexOfSelected != -1) {
      final selectedVariety = varieties.removeAt(indexOfSelected);
      varieties.insert(0, selectedVariety);
    }
    return varieties;
  }

  Variety? _varietySingleFromJsonList(List<Map<String, dynamic>>? json) =>
      json?.map((e) => Variety.fromJson(e)).first;

  @override
  Stream<List<Variety>?> watchVarieties(String? previouslySelectedVarietyId) =>
      _supabaseClient.varieties
          .stream(primaryKey: [VarietyDatabaseKeys.id])
          .order(VarietyDatabaseKeys.name, ascending: true)
          .map((data) => _varietiesFromJson(data, previouslySelectedVarietyId));

  @override
  Stream<Variety?> watchVariety(String varietyId) => _supabaseClient.varieties
      .stream(primaryKey: [VarietyDatabaseKeys.id])
      .eq(VarietyDatabaseKeys.id, varietyId)
      .limit(1)
      .map(_varietySingleFromJsonList);
}
