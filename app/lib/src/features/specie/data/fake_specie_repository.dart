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
  Future<List<Specie>?> getSpecies() async {
    await delay(addDelay);
    return _speciesState.value;
  }
}
