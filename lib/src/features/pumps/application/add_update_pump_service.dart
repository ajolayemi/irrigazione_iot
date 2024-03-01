// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/domain/pump.dart';
import 'package:irrigazione_iot/src/features/user_companies/data/selected_company_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_update_pump_service.g.dart';

class AddUpdatePumpService {
  const AddUpdatePumpService(
    this.ref,
  );
  final Ref ref;

  Future<void> createPump(Pump pump) async {
    final pumpRepo = ref.read(pumpRepositoryProvider);
    final tappedCompanyRepo = ref.read(currentTappedCompanyProvider);
    final companyId = tappedCompanyRepo.valueOrNull?.id;

    // create pump
    await pumpRepo.createPump(pump, companyId ?? '');

  }

  Future<void> updatePump(Pump pump) async {
    final pumpRepo = ref.read(pumpRepositoryProvider);
    final tappedCompanyRepo = ref.read(currentTappedCompanyProvider);
    final companyId = tappedCompanyRepo.valueOrNull?.id;

    // update pump
    await pumpRepo.updatePump(pump, companyId ?? '');

  
  }
}

@Riverpod(keepAlive: true)
AddUpdatePumpService addUpdatePumpService(AddUpdatePumpServiceRef ref) {
  return AddUpdatePumpService(ref);
}
