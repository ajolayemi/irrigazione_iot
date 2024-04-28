import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/data/supabase_available_sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/model/available_sector.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'available_sector_repository.g.dart';

abstract class AvailableSectorRepository {
  Stream<List<AvailableSector>?> watchAvailableSectors(String companyId);
}

@Riverpod(keepAlive: true)
AvailableSectorRepository availableSectorRepository(
    AvailableSectorRepositoryRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabaseAvailableSectorRepository(supabaseClient);
}

@riverpod
Stream<List<AvailableSector>?> availableSectorsStream(
    AvailableSectorsStreamRef ref) {
  final companyId = ref.watch(currentTappedCompanyProvider).valueOrNull?.id;
  if (companyId == null) return Stream.value([]);
  return ref
      .read(availableSectorRepositoryProvider)
      .watchAvailableSectors(companyId);
}
