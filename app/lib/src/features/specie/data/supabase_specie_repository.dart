import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/specie/data/specie_repository.dart';
import 'package:irrigazione_iot/src/features/specie/model/specie.dart';

class SupabaseSpecieRepository implements SpecieRepository {
  const SupabaseSpecieRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  @override
  Future<List<Specie>?> getSpecies() {
    // TODO: implement getSpecieNames
    throw UnimplementedError();
  }
}
