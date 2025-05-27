import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/shared/services/local_data_sync_service.dart';
import 'package:irrigazione_iot/src/shared/services/mqtt_client_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_companies_controller.g.dart';

@Riverpod(keepAlive: true)
class UserCompaniesController extends _$UserCompaniesController {
  @override
  FutureOr<void> build() {}

  Future<void> updateTappedCompanyId(String companyId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _update(companyId));
  }

  Future<void> _update(String companyId) async {
    final uid = ref.read(authRepositoryProvider).currentUser?.uid ?? '';
    final repo = ref.read(selectedCompanyRepositoryProvider);
    await repo.updateSelectedCompanyId(uid, companyId);

    // Invalidate tapped company provider
    final updatedCompany = await ref.refresh(
      currentTappedCompanyProvider.future,
    );

    debugPrint(updatedCompany.toString());

    // Invalidate mqtt client so that it reconnects and subscribes to the correct topics
    final mqttClient = await ref.refresh(
      mqttServerClientProvider.future,
    );

    debugPrint(mqttClient.toString());

    // Invalidate local data sync service and resync data
    final localSyncService = await ref.refresh(localSyncServiceProvider.future);
    await localSyncService.syncServerDataToLocalStorage();
  }
}
