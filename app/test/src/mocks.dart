import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/service/add_update_pump_service.dart';
import 'package:irrigazione_iot/src/features/pumps/data/fake_pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/data/fake_pump_status_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/data/fake_sector_pumps_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/data/fake_sector_status_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/data/fake_sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/service/dismiss_sector_service.dart';
import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockSelectedCompanyRepository extends Mock
    implements SelectedCompanyRepository {}

class MockPumpRepository extends Mock implements FakePumpRepository {}

class MockAddUpdatePumpService extends Mock implements AddUpdatePumpService {}

class MockPumpStatusRepository extends Mock
    implements FakePumpStatusRepository {}

class MockSectorStatusRepository extends Mock
    implements FakeSectorStatusRepository {}

class MockSectorRepository extends Mock implements FakeSectorRepository {}

class MockSectorPumpRepository extends Mock
    implements FakeSectorPumpRepository {}

class MockDismissSectorService extends Mock implements DismissSectorService {}

class Listener<T> extends Mock {
  void call(T? previous, T next);
}
