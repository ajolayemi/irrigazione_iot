import 'package:flutter_test/flutter_test.dart';
import 'package:irrigazione_iot/src/config/mock/fake_companies_list.dart';
import 'package:irrigazione_iot/src/features/user_companies/data/fake_company_repository.dart';

void main() {
  final testCompany = kFakeCompanies.first;
  final testCompanyId = testCompany.id;

  FakeCompanyRepository makeCompanyRepository() => FakeCompanyRepository();

  group('FakeCompanyRepository', () {
    test('fetchCompany returns the company', () async {
      final companyRepository = makeCompanyRepository();
      final company = await companyRepository.fetchCompany(testCompanyId);
      expect(company, testCompany);
    });

    test('watchCompany emits the company', () {
      final companyRepository = makeCompanyRepository();
      expect(companyRepository.watchCompany(testCompanyId), emits(testCompany));
    });

    test('watchCompany emits null when company is not found', () {
      final companyRepository = makeCompanyRepository();
      expect(companyRepository.watchCompany('invalid_id'), emits(null));
    });

    test('watchCompany emits null when company list is empty', () {
      final companyRepository = FakeCompanyRepository(addDelay: false);
      expect(companyRepository.watchCompany('invalid_id'), emits(null));
    });
  });
}
