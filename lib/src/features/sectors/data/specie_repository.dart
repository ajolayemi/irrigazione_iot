import 'package:irrigazione_iot/src/features/sectors/data/fake_specie_repository.dart';
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
  final specieRepository = ref.watch(specieRepositoryProvider);
  return specieRepository.getSpecieNames();
}
