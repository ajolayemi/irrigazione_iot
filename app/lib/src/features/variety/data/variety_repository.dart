import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/variety/data/supabase_variety_repository.dart';
import 'package:irrigazione_iot/src/features/variety/models/variety.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'variety_repository.g.dart';

abstract class VarietyRepository {
  /// Emits a list of [Variety]s
  Stream<List<Variety>?> watchVarieties();

  /// Emits a [Variety] with the given [varietyId]
  Stream<Variety?> watchVariety(String varietyId);

  /// Fetches the [Variety] with the given [varietyId]
  Future<Variety?> getVariety(String varietyId);
}

@Riverpod(keepAlive: true)
VarietyRepository varietyRepository(VarietyRepositoryRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabaseVarietyRepository(supabaseClient);
}

@riverpod
Stream<List<Variety>?> varietiesStream(VarietiesStreamRef ref) {
  final repo = ref.watch(varietyRepositoryProvider);
  return repo.watchVarieties();
}

@riverpod
Future<Variety?> varietyFuture(VarietyFutureRef ref, String varietyId) {
  final repo = ref.watch(varietyRepositoryProvider);
  return repo.getVariety(varietyId);
}

@riverpod
Stream<Variety?> varietyStream(VarietyStreamRef ref, String varietyId) {
  final repo = ref.watch(varietyRepositoryProvider);
  return repo.watchVariety(varietyId);
}
