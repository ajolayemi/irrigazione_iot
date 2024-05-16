import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/variety/data/supabase_variety_repository.dart';
import 'package:irrigazione_iot/src/features/variety/models/variety.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'variety_repository.g.dart';

abstract class VarietyRepository {
  Stream<List<Variety>?> watchVarieties(String? previouslySelectedVarietyId);
  Stream<Variety?> watchVariety(String varietyId);
}

@Riverpod(keepAlive: true)
VarietyRepository varietyRepository(VarietyRepositoryRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabaseVarietyRepository(supabaseClient);
}

@riverpod
Stream<List<Variety>?> varietiesStream(VarietiesStreamRef ref,
    {String? previouslySelectedVarietyId}) {
  final repo = ref.watch(varietyRepositoryProvider);
  return repo.watchVarieties(previouslySelectedVarietyId);
}

@riverpod
Stream<Variety?> varietyStream(VarietyStreamRef ref, String varietyId) {
  final repo = ref.watch(varietyRepositoryProvider);
  return repo.watchVariety(varietyId);
}
