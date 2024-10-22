import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:irrigazione_iot/src/constants/app_constants.dart';

part 'shared_preferences_service.g.dart';

class SharedPreferencesService {
  // Holds onto the retrieved token
  static const String _weenatTokenSuffixKey = 'weenat_token';

  // The last time that a token was updated
  static const String _weenatTimestampTokenSuffixKey = 'weenat_timestamp_token';

  // The last time plot sensor data for a particular plot was updated
  static const String _weenatPlotSensorDataTimestampKey =
      'weenat_plot_sensor_data_timestamp';

  String _buildFinalKey({
    required String prefix,
    required String key,
  }) {
    return '$prefix _$key';
  }

  /// Clears all currently saved weenat token preferences
  Future<void> clearWeenatTokenPrefs({String? uid}) async {
    if (uid == null || uid.isEmpty) return;

    final pref = await SharedPreferences.getInstance();

    final prefKey = _buildFinalKey(
      prefix: uid,
      key: _weenatTokenSuffixKey,
    );
    final timestampKey = _buildFinalKey(
      prefix: uid,
      key: _weenatTimestampTokenSuffixKey,
    );

    pref.remove(prefKey);
    pref.remove(timestampKey);
  }

  /// Saves current user's weenat token to saved preferences
  Future<void> setUserWeenatToken({
    required String token,
    String? uid,
  }) async {
    if (uid == null || uid.isEmpty) return;

    final pref = await SharedPreferences.getInstance();

    final prefKey = _buildFinalKey(
      prefix: uid,
      key: _weenatTokenSuffixKey,
    );
    final timestampKey = _buildFinalKey(
      prefix: uid,
      key: _weenatTimestampTokenSuffixKey,
    );
    pref.setString(prefKey, token);
    pref.setString(
      timestampKey,
      DateTime.now().toIso8601String(),
    );
  }

  /// Retrieves the current user's weenat token from saved preferences
  ///
  /// It also handles checking if saved token is still valid and deletes
  /// old values if it isn't valid anymore.
  ///
  /// Weenat tokens are currently valid for 365 days
  ///
  Future<String?> getUserWeenatToken({String? uid}) async {
    if (uid == null || uid.isEmpty) return null;

    final pref = await SharedPreferences.getInstance();
    final prefKey = _buildFinalKey(
      prefix: uid,
      key: _weenatTokenSuffixKey,
    );
    final timestampKey = _buildFinalKey(
      prefix: uid,
      key: _weenatTimestampTokenSuffixKey,
    );
    final token = pref.getString(prefKey);
    final tokenTimestamp = DateTime.tryParse(
      pref.getString(timestampKey) ?? '',
    );

    if (tokenTimestamp == null) return null;

    final daysPassed = DateTime.now().difference(tokenTimestamp).inDays;

    if (daysPassed > AppConstants.weenatTokenValidityDays) {
      // Delete old values
      pref.remove(prefKey);
      pref.remove(timestampKey);
      return null;
    }

    return token;
  }

  /// Saves the last time that plot sensor data was updated
  /// for a particular plot
  Future<void> setPlotSensorDataTimestamp({
    required int plotId,
    required DateTime timestamp,
  }) async {
    final pref = await SharedPreferences.getInstance();
    final prefKey = _buildFinalKey(
      prefix: plotId.toString(),
      key: _weenatPlotSensorDataTimestampKey,
    );
    pref.setString(
      prefKey,
      timestamp.toIso8601String(),
    );
  }

  /// Retrieves the last time that plot sensor data was updated
  /// for a particular plot
  Future<DateTime?> getPlotSensorDataTimestamp({required int plotId}) async {
    final pref = await SharedPreferences.getInstance();
    final prefKey = _buildFinalKey(
      prefix: plotId.toString(),
      key: _weenatPlotSensorDataTimestampKey,
    );
    final timestamp = pref.getString(prefKey);
    return DateTime.tryParse(timestamp ?? '');
  }
}

@Riverpod(keepAlive: true)
SharedPreferencesService sharedPrefsService(SharedPrefsServiceRef ref) {
  return SharedPreferencesService();
}
