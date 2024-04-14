// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';
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
    await pumpRepo.createPump(pump, companyId ?? '');
  }

  Future<void> updatePump(Pump pump) async {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user == null) return;

    final pumpRepo = ref.read(pumpRepositoryProvider);
    final selectedCompanyRepo = ref.read(selectedCompanyRepositoryProvider);
    final companyId = selectedCompanyRepo.loadSelectedCompanyId(user.uid);

    // update pump
    await pumpRepo.updatePump(pump, companyId ?? '');
  }
}

@Riverpod(keepAlive: true)
AddUpdatePumpService addUpdatePumpService(AddUpdatePumpServiceRef ref) {
  return AddUpdatePumpService(ref);
}
