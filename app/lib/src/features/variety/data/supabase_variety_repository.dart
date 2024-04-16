import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/variety/data/variety_repository.dart';
import 'package:irrigazione_iot/src/features/variety/model/variety.dart';

class SupabaseVarietyRepository implements VarietyRepository {
  const SupabaseVarietyRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  @override
  Future<List<Variety>?> getVarieties() {
    // TODO: implement getVarieties
    throw UnimplementedError();
  }
}
