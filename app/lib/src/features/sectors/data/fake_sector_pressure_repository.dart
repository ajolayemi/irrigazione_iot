import 'package:irrigazione_iot/src/features/sectors/data/sector_pressure_repository.dart';

class FakeSectorPressureRepository extends SectorPressureRepository {
  @override
  Stream<DateTime?> watchLastPressureReading(String sectorId) {
    return Stream.value(DateTime.now());
  }
}
