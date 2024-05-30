// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_pump_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_update_pump_service.g.dart';

class AddUpdatePumpService {
  const AddUpdatePumpService(
    this.ref,
  );
  final Ref ref;

  Future<void> createPump(Pump pump) async {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user == null) return;

    final pumpRepo = ref.read(pumpRepositoryProvider);
    final selectedCompanyRepo = ref.read(selectedCompanyRepositoryProvider);
    final companyId = selectedCompanyRepo.loadSelectedCompanyId(user.uid);

    // create pump
    await pumpRepo.createPump(pump.copyWith(companyId: companyId));

    _invalidatePumpList();
  }

  Future<void> updatePump(Pump pump) async {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user == null) return;

    final pumpRepo = ref.read(pumpRepositoryProvider);
    final selectedCompanyRepo = ref.read(selectedCompanyRepositoryProvider);
    final companyId = selectedCompanyRepo.loadSelectedCompanyId(user.uid);

    // update pump
    await pumpRepo.updatePump(pump.copyWith(companyId: companyId));

    _invalidatePumpList();
  }

  /// Forces the pump list future to refresh by invalidating it
  void _invalidatePumpList() {
    // invalidate the available pumps so that the newly created pump is included
    ref.invalidate(availablePumpsFutureProvider);

    // invalidate the general list of pumps, this forces its state to refresh
    ref.invalidate(companyPumpsFutureProvider);
  }
}

@Riverpod(keepAlive: true)
AddUpdatePumpService addUpdatePumpService(AddUpdatePumpServiceRef ref) {
  return AddUpdatePumpService(ref);
}
