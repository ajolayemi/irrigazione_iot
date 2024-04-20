import 'package:irrigazione_iot/src/features/specie/model/specie_database_keys.dart';
import 'package:irrigazione_iot/src/utils/supabase_extensions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/specie/data/specie_repository.dart';
import 'package:irrigazione_iot/src/features/specie/model/specie.dart';

class SupabaseSpecieRepository implements SpecieRepository {
  const SupabaseSpecieRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  List<Specie>? _speciesFromJson(
      List<Map<String, dynamic>>? json, String? selectedId) {
    if (json == null) return null;
    final species = json.map((e) => Specie.fromJson(e)).toList();
    final indexOfSelected =
        species.indexWhere((specie) => specie.id == selectedId);
    if (indexOfSelected != -1) {
      final selectedSpecie = species.removeAt(indexOfSelected);
      species.insert(0, selectedSpecie);
    }
    return species;
  }

  @override
  Stream<List<Specie>?> watchSpecies({
    String? previouslySelectedSpecieId,
  }) {
    final stream = _supabaseClient.species.stream(primaryKey: [
      SpecieDatabaseKeys.id
    ]).order(SpecieDatabaseKeys.name, ascending: true);
    return stream
        .map((data) => _speciesFromJson(data, previouslySelectedSpecieId));
  }
}
