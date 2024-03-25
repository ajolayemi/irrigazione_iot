import 'package:flutter_test/flutter_test.dart';
import 'package:irrigazione_iot/src/config/mock/fake_users_list.dart';
import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  final testUid = kFakeUsers.first.uid;
  const testCompanyId = '1';
  final prefKey = '$testUid-${SelectedCompanyRepository.prefKey}';

  Future<SelectedCompanyRepository> makeSelectedCompanyRepository() async {
    final prefs = await SharedPreferences.getInstance();
    return SelectedCompanyRepository(prefs: prefs);
  }

  group('SelectedCompanyRepository', () {
    test('loadSelectedCompanyId returns valid value', () async {
      SharedPreferences.setMockInitialValues({prefKey: testCompanyId});
      final repo = await makeSelectedCompanyRepository();
      final res = repo.loadSelectedCompanyId(testUid);
      expect(res, testCompanyId);
    });

    test('loadSelectedCompanyId returns null', () async {
      // Not setting initial mock values for SharedPreferences
      SharedPreferences.setMockInitialValues({});
      final repo = await makeSelectedCompanyRepository();
      final res = repo.loadSelectedCompanyId(testUid);
      expect(res, isNull);
    });

    test(
        'updateSelectedCompanyId updates previous empty preferences as expected',
        () async {
      SharedPreferences.setMockInitialValues({});
      final repo = await makeSelectedCompanyRepository();

      // load selected company id should be null at this point
      expect(repo.loadSelectedCompanyId(testUid), isNull);

      // update user's preferences
      await repo.updateSelectedCompanyId(testUid, testCompanyId);
      expect(repo.loadSelectedCompanyId(testUid), testCompanyId);
    });

    test(
        'updateSelectedCompanyId updates previous non-empty preferences as expected',
        () async {
      SharedPreferences.setMockInitialValues({prefKey: '2'});
      final repo = await makeSelectedCompanyRepository();

      // load selected company id should be 2 at this point
      expect(repo.loadSelectedCompanyId(testUid), '2');

      // update user's preferences
      await repo.updateSelectedCompanyId(testUid, '3');
      expect(repo.loadSelectedCompanyId(testUid), '3');
    });
  });
}
