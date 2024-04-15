import 'package:irrigazione_iot/src/config/mock/fake_species.dart';
import 'package:irrigazione_iot/src/features/specie/data/specie_repository.dart';
import 'package:irrigazione_iot/src/features/specie/model/specie.dart';
import 'package:irrigazione_iot/src/utils/delay.dart';
import 'package:irrigazione_iot/src/utils/in_memory_store.dart';

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
