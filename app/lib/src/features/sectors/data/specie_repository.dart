import 'dart:async';

import 'fake_specie_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'specie_repository.g.dart';

abstract class SpecieRepository {
  Future<List<String>> getSpecieNames();
}

@Riverpod(keepAlive: true)
SpecieRepository specieRepository(SpecieRepositoryRef ref) {
  return FakeSpecieRepository();
}

@riverpod
Future<List<String>> specieNamesFuture(SpecieNamesFutureRef ref) {
  final link = ref.keepAlive();
  // * keep the previous value in memory for 60 seconds
  final timer = Timer(const Duration(seconds: 60), link.close);
  ref.onDispose(() => timer.cancel());
  final specieRepository = ref.watch(specieRepositoryProvider);
  return specieRepository.getSpecieNames();
}
