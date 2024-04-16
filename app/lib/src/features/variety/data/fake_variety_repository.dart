import 'package:irrigazione_iot/src/config/mock/fake_varieties.dart';
import 'package:irrigazione_iot/src/features/variety/data/variety_repository.dart';
import 'package:irrigazione_iot/src/features/variety/model/variety.dart';
import 'package:irrigazione_iot/src/utils/delay.dart';
import 'package:irrigazione_iot/src/utils/in_memory_store.dart';

class FakeVarietyRepository implements VarietyRepository {
  FakeVarietyRepository({this.addDelay = true});
  final bool addDelay;
  final _speciesState = InMemoryStore<List<Variety>>(kFakeVarieties);
  @override
  Future<List<Variety>?> getVarieties() async {
    await delay(addDelay);
    return _speciesState.value;
  }

  void dispose() => _speciesState.close();
}
