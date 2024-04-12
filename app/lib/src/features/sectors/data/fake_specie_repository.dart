import '../../../config/mock/fake_species.dart';
import 'specie_repository.dart';
import '../model/specie.dart';
import '../../../utils/delay.dart';
import '../../../utils/in_memory_store.dart';

class FakeSpecieRepository implements SpecieRepository {
  FakeSpecieRepository({this.addDelay = true});
  final bool addDelay;

  final _speciesState = InMemoryStore<List<Specie>>(kFakeSpecies);

  void dispose() => _speciesState.close();

  @override
  Future<List<String>> getSpecieNames() async {
    await delay(addDelay);
    // build a list containing unique species names
    final speciesNames = _speciesState.value
        .map((specie) => specie.name)
        .toSet()
        .toList(growable: false);
    speciesNames.sort((a, b) => a.compareTo(b));
    return speciesNames;
  }
}
