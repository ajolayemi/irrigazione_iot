import 'package:irrigazione_iot/src/config/mock/fake_companies_list.dart';
import 'package:irrigazione_iot/src/features/user_companies/data/company_repository.dart';
import 'package:irrigazione_iot/src/features/user_companies/domain/company.dart';
import 'package:irrigazione_iot/src/utils/delay.dart';
import 'package:irrigazione_iot/src/utils/in_memory_store.dart';

class FakeCompanyRepository implements CompanyRepository {
  FakeCompanyRepository({this.addDelay = true});

  final bool addDelay;
  final _companies = InMemoryStore<List<Company>>(kFakeCompanies);
  @override
  Future<Company?> fetchCompany(CompanyID companyId) async {
    await delay(addDelay);
    return Future.value(_getCompany(_companies.value, companyId));
  }

  @override
  Stream<Company?> watchCompany(CompanyID companyId) {
    return _companies.stream
        .map((companies) => _getCompany(companies, companyId));
  }

  static Company? _getCompany(List<Company> companies, CompanyID companyId) {
    try {
      return companies.firstWhere((company) => company.id == companyId);
    } catch (e) {
      return null;
    }
  }
}
