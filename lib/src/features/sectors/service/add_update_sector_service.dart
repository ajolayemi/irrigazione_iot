import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector.dart';
import 'package:irrigazione_iot/src/features/user_companies/data/selected_company_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_update_sector_service.g.dart';

class AddUpdateSectorService {
  const AddUpdateSectorService(
    this.ref,
  );
  final Ref ref;

  Future<void> createSector(Sector sector) async {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user == null) return;

    final sectorRepo = ref.read(sectorsRepositoryProvider);
    final selectedCompanyRepo = ref.read(selectedCompanyRepositoryProvider);
    final companyId = selectedCompanyRepo.loadSelectedCompanyId(user.uid);

    // create sector
    await sectorRepo.addSector(sector, companyId ?? '');
  }

  Future<void> updateSector(Sector sector) async {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user == null) return;

    final sectorRepo = ref.read(sectorsRepositoryProvider);
    final selectedCompanyRepo = ref.read(selectedCompanyRepositoryProvider);
    final companyId = selectedCompanyRepo.loadSelectedCompanyId(user.uid);

    // update sector
    await sectorRepo.updateSector(sector, companyId ?? '');
  }
}


@Riverpod(keepAlive: true)
AddUpdateSectorService addUpdateSectorService(AddUpdateSectorServiceRef ref) {
  return AddUpdateSectorService(ref);
}