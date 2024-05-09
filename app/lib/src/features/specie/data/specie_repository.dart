import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/specie/data/supabase_specie_repository.dart';
import 'package:irrigazione_iot/src/features/specie/models/specie.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'specie_repository.g.dart';

abstract class SpecieRepository {
  Stream<List<Specie>?> watchSpecies({String? previouslySelectedSpecieId});
  Stream<Specie?> watchSpecie(String specieId);
}

@Riverpod(keepAlive: true)
SpecieRepository specieRepository(SpecieRepositoryRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabaseSpecieRepository(supabaseClient);
}

@riverpod
Stream<List<Specie>?> speciesStream(SpeciesStreamRef ref,
    {String? previouslySelectedSpecieId}) {
  final repo = ref.watch(specieRepositoryProvider);
  return repo.watchSpecies(previouslySelectedSpecieId: previouslySelectedSpecieId);
}

@riverpod
Stream<Specie?> specieStream(SpecieStreamRef ref, String specieId) {
  final repo = ref.watch(specieRepositoryProvider);
  return repo.watchSpecie(specieId);
}
