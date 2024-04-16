import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/specie/data/specie_repository.dart';

class SupabaseSpecieRepository implements SpecieRepository {

  const SupabaseSpecieRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;
  
  @override
  Future<List<String>> getSpecieNames() {
    // TODO: implement getSpecieNames
    throw UnimplementedError();
  }
}