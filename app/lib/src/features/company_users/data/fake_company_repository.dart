import 'package:irrigazione_iot/src/config/mock/fake_companies_list.dart';
import 'package:irrigazione_iot/src/features/company_users/data/company_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/model/company.dart';
import 'package:irrigazione_iot/src/utils/delay.dart';
import 'package:irrigazione_iot/src/utils/in_memory_store.dart';

class FakeCompanyRepository implements CompanyRepository {
  FakeCompanyRepository({this.addDelay = true});

  final bool addDelay;
  final _companies = InMemoryStore<List<Company>>(kFakeCompanies);
  @override
  Future<Company?> fetchCompany(String companyId) async {
    await delay(addDelay);
    return Future.value(_getCompany(_companies.value, companyId));
  }

  @override
  Stream<Company?> watchCompany(String companyId) {
    return _companies.stream
        .map((companies) => _getCompany(companies, companyId));
  }

  static Company? _getCompany(List<Company> companies, String companyId) {
    try {
      return companies.firstWhere((company) => company.id == companyId);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Company?> addCompany({required Company company}) async {
    await delay(addDelay);

    final lastId = _companies.value
        .map((e) => int.tryParse(e.id) ?? 0)
        .reduce((maxId, currentId) => maxId > currentId ? maxId : currentId);
    final newCompany = company.copyWith(
      id: (lastId + 1).toString(),
    );
    final currentCompanies = [..._companies.value];
    currentCompanies.add(newCompany);
    _companies.value = currentCompanies;
    return fetchCompany(newCompany.id);
  }

  @override
  Future<bool> deleteCompany({required String companyId}) async {
    await delay(addDelay);
    final currentCompanies = [..._companies.value];
    final index = currentCompanies.indexWhere((company) => company.id == companyId);
    if (index == -1) return false;
    currentCompanies.removeAt(index);
    _companies.value = currentCompanies;
    return await fetchCompany(companyId) == null;
  }

  @override
  Future<Company?> updateCompany({required Company company}) async {
    await delay(addDelay);
    final currentCompanies = [..._companies.value];
    final index = currentCompanies.indexWhere((c) => c.id == company.id);
    if (index == -1) return null;
    currentCompanies[index] = company;
    _companies.value = currentCompanies;
    return fetchCompany(company.id);

  }

  void dispose() => _companies.close();
}
