import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/data/datasource/dao/weenat_dao.dart';
import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/weenat/data/weenat_repository.dart';
import 'package:irrigazione_iot/src/features/weenat/models/weenat_auth_payload.dart';
import 'package:irrigazione_iot/src/features/weenat/models/weenat_plot.dart';
import 'package:irrigazione_iot/src/features/weenat/providers/weenat_providers.dart';
import 'package:irrigazione_iot/src/shared/services/shared_preferences_service.dart';

part 'weenat_service.g.dart';

class WeenatService {
  WeenatService(this._ref);
  final Ref _ref;

  Future<bool> authWeenatService({
    required WeenatAuthPayload payload,
  }) async {
    try {
      // Access repository
      final repo = _ref.read(weenatRepositoryProvider);

      final prefService = _ref.read(sharedPrefsServiceProvider);
      final uid = _ref.read(userUidProvider);
      // Clear current saved preferences
      prefService.clearWeenatTokenPrefs(uid: uid);

      // Make call to authenticate
      final token = await repo.authWeenat(payload: payload);
      if (token == null || token.isEmpty) {
        return false;
      }

      // Save token to shared preferences
      await prefService.setUserWeenatToken(
        token: token,
        uid: uid,
      );

      // After successful authentication, make call to get plots
      final plots = await repo.getPlots(token: token) ?? [];
      final plotsEntities = plots.toEntities();
      // Insert plots into local database
      await _ref
          .read(weenatDaoProvider)
          .insertWeenatPlots(plots: plotsEntities);

      return true;
    } catch (error) {
      rethrow;
    } finally {
      _ref.invalidate(weenatTokenProvider);
    }
  }
}

@Riverpod(keepAlive: true)
WeenatService weenatService(WeenatServiceRef ref) {
  return WeenatService(ref);
}
