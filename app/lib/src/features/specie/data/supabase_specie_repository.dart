import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/specie/data/specie_repository.dart';
import 'package:irrigazione_iot/src/features/specie/models/specie.dart';
import 'package:irrigazione_iot/src/features/specie/models/specie_database_keys.dart';
import 'package:irrigazione_iot/src/utils/extensions/supabase_extensions.dart';

class SupabaseSpecieRepository implements SpecieRepository {
  const SupabaseSpecieRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  List<Specie>? _speciesFromJson(List<Map<String, dynamic>>? json) {
    if (json == null) return null;
    return json.map((e) => Specie.fromJson(e)).toList();
  }

  Specie? _specieSingleFromJsonList(List<Map<String, dynamic>>? json) =>
      json?.map((e) => Specie.fromJson(e)).first;

  Specie? _toSpecie(Map<String, dynamic>? json) =>
      json == null ? null : Specie.fromJson(json);

  @override
  Stream<List<Specie>?> watchSpecies() {
    final stream = _supabaseClient.species.stream(primaryKey: [
      SpecieDatabaseKeys.id
    ]).order(SpecieDatabaseKeys.name, ascending: true);
    return stream.map((data) => _speciesFromJson(data));
  }

  @override
  Stream<Specie?> watchSpecie(String specieId) => _supabaseClient.species
      .stream(primaryKey: [SpecieDatabaseKeys.id])
      .eq(SpecieDatabaseKeys.id, specieId)
      .limit(1)
      .map(_specieSingleFromJsonList);

  @override
  Future<Specie?> getSpecie(String specieId) async {
    final data = await _supabaseClient.species
        .select()
        .eq(SpecieDatabaseKeys.id, specieId)
        .maybeSingle()
        .withConverter(_toSpecie);
    return data;
  }

  @override
  Future<List<Specie>?> getSpecies() async {
    final data = await _supabaseClient.species
        .select()
        .order(SpecieDatabaseKeys.name, ascending: true)
        .withConverter(_speciesFromJson);
    return data;
  }
}
