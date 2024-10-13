// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:irrigazione_iot/src/data/datasource/dao/weenat_dao.dart';
import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/weenat/models/weenat_plot.dart';
import 'package:irrigazione_iot/src/features/weenat/models/weenat_org.dart';
import 'package:irrigazione_iot/src/shared/services/shared_preferences_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weenat_providers.g.dart';

/// Holds onto the current available weenat token retrieved from
///
/// shared preferences
@Riverpod(keepAlive: true)
FutureOr<String?> weenatToken(WeenatTokenRef ref) {
  final prefService = ref.watch(sharedPrefsServiceProvider);
  final uid = ref.watch(authRepositoryProvider).currentUser?.uid;
  return prefService.getUserWeenatToken(uid: uid);
}

@Riverpod(keepAlive: true)
bool hasWeenatToken(HasWeenatTokenRef ref) {
  final token = ref.watch(weenatTokenProvider).valueOrNull;
  return token != null && token.isNotEmpty;
}

/// Access local database to retrieve list of available
/// [WeenatOrg]s
@Riverpod(keepAlive: true)
FutureOr<List<WeenatOrg>?> weenatOrgs(WeenatOrgsRef ref) async {
  final dao = ref.watch(weenatDaoProvider);
  final entities = await dao.getWeenatOrgs() ?? [];
  return entities.toModels(entities);
}

/// Holds onto the current selected [WeenatOrg]
@Riverpod(keepAlive: true)
class SelectedWeenatOrg extends _$SelectedWeenatOrg {
  @override
  WeenatOrg? build() {
    final orgs = ref.watch(weenatOrgsProvider).valueOrNull;
    if (orgs == null || orgs.isEmpty) return null;
    return orgs.first;
  }

  void setSelected(WeenatOrg? org) => state = org;
}

/// Holds onto the index of the selected [WeenatOrg]
@Riverpod(keepAlive: true)
int? selectedOrgIndex(SelectedOrgIndexRef ref) {
  final orgs = ref.watch(weenatOrgsProvider).valueOrNull;
  final selectedOrg = ref.watch(selectedWeenatOrgProvider);
  if (orgs == null || orgs.isEmpty || selectedOrg == null) return null;
  return orgs.indexOf(selectedOrg);
}

/// Access local database to retrieve list of available
/// [WeenatPlot]s for the selected [WeenatOrg]
@Riverpod(keepAlive: true)
FutureOr<List<WeenatPlot>?> weenatPlotsForOrg(WeenatPlotsForOrgRef ref) async {
  final orgId = ref.watch(selectedWeenatOrgProvider.select((val) => val?.id));
  final dao = ref.watch(weenatDaoProvider);
  final entities = await dao.getWeenatPlotsForOrg(orgId) ?? [];
  return entities.toModels(entities);
}

/// Holds onto the static lists of available tensiometers ranges
@Riverpod(keepAlive: true)
List<String> tensiometerRanges(TensiometerRangesRef ref) {
  return ['15', '30', '45'];
}

/// Holds onto the current selected tensiometer range
@Riverpod(keepAlive: true)
class SelectedTensiometerRange extends _$SelectedTensiometerRange {
  @override
  String? build() {
    final ranges = ref.watch(tensiometerRangesProvider);
    if (ranges.isEmpty) return null;
    return ranges.first;
  }

  void setSelected(String? range) => state = range;
}

/// Checks to see if a tensiometer range is selected
@Riverpod(keepAlive: true)
bool tensiometerRangeIsSelected(
  TensiometerRangeIsSelectedRef ref,
  String range,
) {
  return ref.watch(selectedTensiometerRangeProvider) == range;
}
