import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/specie/data/supabase_specie_repository.dart';
import 'package:irrigazione_iot/src/features/specie/model/specie.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'specie_repository.g.dart';

abstract class SpecieRepository {
  Future<List<Specie>?> getSpecieNames();
}

@Riverpod(keepAlive: true)
SpecieRepository specieRepository(SpecieRepositoryRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabaseSpecieRepository(supabaseClient);
}

@riverpod
Future<List<Specie>?> specieFuture(SpecieFutureRef ref) {
  final link = ref.keepAlive();
  // * keep the previous value in memory for 60 seconds
  final timer = Timer(const Duration(seconds: 60), link.close);
  ref.onDispose(() => timer.cancel());
  final specieRepository = ref.watch(specieRepositoryProvider);
  return specieRepository.getSpecieNames();
}
