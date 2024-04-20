import 'package:collection/collection.dart';
import 'package:irrigazione_iot/src/config/mock/fake_species.dart';
import 'package:irrigazione_iot/src/features/specie/data/specie_repository.dart';
import 'package:irrigazione_iot/src/features/specie/model/specie.dart';
import 'package:irrigazione_iot/src/utils/in_memory_store.dart';

class FakeSpecieRepository implements SpecieRepository {
  FakeSpecieRepository({this.addDelay = true});
  final bool addDelay;

  final _speciesState = InMemoryStore<List<Specie>>(kFakeSpecies);

  void dispose() => _speciesState.close();

  @override
  Stream<List<Specie>?> watchSpecies({
    String? previouslySelectedSpecieId,
  }) =>
      _speciesState.stream;

  @override
  Stream<Specie?> watchSpecie(String specieId) => _speciesState.stream
      .map((species) => species.firstWhereOrNull((s) => s.id == specieId));
}
