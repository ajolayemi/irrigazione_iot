import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/features/dashboard/data/supabase_dashboard_repository.dart';
import 'package:irrigazione_iot/src/features/dashboard/models/pump_switched_on.dart';
import 'package:irrigazione_iot/src/features/dashboard/models/sector_switched_on.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_repository.g.dart';

abstract class DashboardRepository {
  /// Emits a list of [PumpSwitchedOn]s for the provided [companyId].
  Stream<List<PumpSwitchedOn>?> watchPumpsSwitchedOn(String companyId);

  /// Emits a list of [SectorSwitchedOn]s for the provided [companyId].
  Stream<List<SectorSwitchedOn>?> watchSectorsSwitchedOn(String companyId);
}

@Riverpod(keepAlive: true)
DashboardRepository dashboardRepository(DashboardRepositoryRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabaseDashboardRepository(supabaseClient);
}

@riverpod
Stream<List<PumpSwitchedOn>?> pumpsSwitchedOnStream(
    PumpsSwitchedOnStreamRef ref) {
  final currentSelectedCompanyByUser =
      ref.watch(currentTappedCompanyProvider).value;
  if (currentSelectedCompanyByUser == null) return Stream.value([]);
  final dashboardRepo = ref.watch(dashboardRepositoryProvider);
  return dashboardRepo.watchPumpsSwitchedOn(currentSelectedCompanyByUser.id);
}

@riverpod
Stream<List<SectorSwitchedOn>?> sectorsSwitchedOnStream(
    SectorsSwitchedOnStreamRef ref) {
  final currentSelectedCompanyByUser =
      ref.watch(currentTappedCompanyProvider).value;
  if (currentSelectedCompanyByUser == null) return Stream.value([]);
  final dashboardRepo = ref.watch(dashboardRepositoryProvider);
  return dashboardRepo.watchSectorsSwitchedOn(currentSelectedCompanyByUser.id);
}