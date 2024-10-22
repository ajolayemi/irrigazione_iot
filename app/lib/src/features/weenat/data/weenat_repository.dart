import 'package:irrigazione_iot/src/features/weenat/data/weenat_repository_impl.dart';
import 'package:irrigazione_iot/src/features/weenat/models/weenat_auth_payload.dart';
import 'package:irrigazione_iot/src/features/weenat/models/weenat_plot.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weenat_repository.g.dart';

abstract class WeenatRepository {
  /// Handles weenat token retrieval, which is basically
  /// the authentication flow for weenat
  ///
  /// Returns the authentication token
  Future<String?> authWeenat({required WeenatAuthPayload payload});

  /// Retrieves the list of plots associated with the current
  /// weenat account
  Future<List<WeenatPlot>?> getPlots({required String token});

  /// Retrieves the list of measures for a particular plot with
  /// [plotId] in the given [orgId] in the provided [unixStart] to [unixEnd] timestamps
  Future<Map<String, dynamic>?> getMeasures({
    required int plotId,
    required int unixStart,
    required int unixEnd,
    required String token,
    int? orgId,
  });
}

@Riverpod(keepAlive: true)
WeenatRepository weenatRepository(WeenatRepositoryRef ref) {
  return WeenatRepositoryImpl("https://api-prod.weenat.com/api");
}
