import 'package:irrigazione_iot/src/data/datasource/dao/weenat_dao.dart';
import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/weenat/models/weenat_plot.dart';
import 'package:irrigazione_iot/src/features/weenat/models/weenat_plot_org.dart';
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
/// [WeenatPlotOrg]s
@Riverpod(keepAlive: true)
FutureOr<List<WeenatPlotOrg>?> weenatPlotOrgs(WeenatPlotOrgsRef ref) async {
  final dao = ref.watch(weenatDaoProvider);
  final entities = await dao.getWeenatOrgs() ?? [];
  return entities.toModels(entities);
}

/// Holds onto the current selected [WeenatPlotOrg]
@Riverpod(keepAlive: true)
class SelectedWeenatOrg extends _$SelectedWeenatOrg {
  @override
  WeenatPlotOrg? build() {
    final orgs = ref.watch(weenatPlotOrgsProvider).valueOrNull;
    if (orgs == null || orgs.isEmpty) return null;
    return orgs.first;
  }

  void setSelected(WeenatPlotOrg? org) => state = org;
}

/// Access local database to retrieve list of available
/// [WeenatPlot]s for the selected [WeenatPlotOrg]
@Riverpod(keepAlive: true)
FutureOr<List<WeenatPlot>?> weenatPlotsForOrg(WeenatPlotsForOrgRef ref) async {
  final orgId = ref.watch(selectedWeenatOrgProvider.select((val) => val?.id));
  final dao = ref.watch(weenatDaoProvider);
  final entities = await dao.getWeenatPlotsForOrg(orgId) ?? [];
  return entities.toModels(entities);
}
