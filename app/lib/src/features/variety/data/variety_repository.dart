import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/variety/data/supabase_variety_repository.dart';
import 'package:irrigazione_iot/src/features/variety/model/variety.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'variety_repository.g.dart';

abstract class VarietyRepository {
  Future<List<Variety>?> getVarieties();
}

@Riverpod(keepAlive: true)
VarietyRepository varietyRepository(VarietyRepositoryRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabaseVarietyRepository(supabaseClient);
}

@riverpod
Future<List<Variety>?> varietiesFuture(VarietiesFutureRef ref) {
  final link = ref.keepAlive();
  // * keep the previous value in memory for 60 seconds
  final timer = Timer(const Duration(seconds: 60), link.close);
  ref.onDispose(() => timer.cancel());
  final varietyRepository = ref.watch(varietyRepositoryProvider);
  return varietyRepository.getVarieties();
}