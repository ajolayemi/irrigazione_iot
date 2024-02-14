import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class Listener<T> extends Mock {
  void call(T? previous, T next);
}
