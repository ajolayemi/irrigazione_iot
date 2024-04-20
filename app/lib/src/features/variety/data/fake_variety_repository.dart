import 'package:collection/collection.dart';
import 'package:irrigazione_iot/src/config/mock/fake_varieties.dart';
import 'package:irrigazione_iot/src/features/variety/data/variety_repository.dart';
import 'package:irrigazione_iot/src/features/variety/model/variety.dart';
import 'package:irrigazione_iot/src/utils/in_memory_store.dart';

class FakeVarietyRepository implements VarietyRepository {
  FakeVarietyRepository({this.addDelay = true});
  final bool addDelay;
  final _varietyState = InMemoryStore<List<Variety>>(kFakeVarieties);

  void dispose() => _varietyState.close();

  @override
  Stream<List<Variety>?> watchVarieties(String? previouslySelectedVarietyId) => _varietyState.stream;
  
  @override
  Stream<Variety?> watchVariety(String varietyId) => _varietyState.stream
      .map((varieties) => varieties.firstWhereOrNull((v) => v.id == varietyId));
}
