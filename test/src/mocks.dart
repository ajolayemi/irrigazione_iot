import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/data/fake_pump_repository.dart';
import 'package:irrigazione_iot/src/features/user_companies/data/selected_company_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}
class MockSelectedCompanyRepository extends Mock implements SelectedCompanyRepository {}
class MockPumpRepository extends Mock implements FakePumpRepository {}
class Listener<T> extends Mock {
  void call(T? previous, T next);
}
