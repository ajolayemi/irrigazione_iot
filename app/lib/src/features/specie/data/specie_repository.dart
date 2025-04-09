import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/specie/data/supabase_specie_repository.dart';
import 'package:irrigazione_iot/src/features/specie/models/specie.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'specie_repository.g.dart';

abstract class SpecieRepository {
  /// Emits a list of [Specie]s
  Stream<List<Specie>?> watchSpecies();

  /// Fetches the list of [Specie]s
  Future<List<Specie>?> getSpecies();

  /// Emits a [Specie] with the given [specieId]
  Stream<Specie?> watchSpecie(String specieId);

  /// Fetches the [Specie] with the given [specieId]
  Future<Specie?> getSpecie(String specieId);
}

@Riverpod(keepAlive: true)
SpecieRepository specieRepository(Ref ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabaseSpecieRepository(supabaseClient);
}

@riverpod
Stream<List<Specie>?> speciesStream(Ref ref) {
  final repo = ref.watch(specieRepositoryProvider);
  return repo.watchSpecies();
}

@riverpod
Future<List<Specie>?> speciesFuture(Ref ref) {
  final repo = ref.watch(specieRepositoryProvider);
  return repo.getSpecies();
}

@riverpod
Stream<Specie?> specieStream(Ref ref, String specieId) {
  final repo = ref.watch(specieRepositoryProvider);
  return repo.watchSpecie(specieId);
}

@riverpod
Future<Specie?> specieFuture(Ref ref, String specieId) {
  final repo = ref.watch(specieRepositoryProvider);
  return repo.getSpecie(specieId);
}
