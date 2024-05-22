import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/terminal/data/terminal_pressure_repository.dart';
import 'package:irrigazione_iot/src/features/terminal/models/terminal_pressure.dart';
import 'package:irrigazione_iot/src/features/terminal/models/terminal_pressure_database_keys.dart';
import 'package:irrigazione_iot/src/utils/extensions/supabase_extensions.dart';

class SupabaseTerminalPressureRepository implements TerminalPressureRepository {
  const SupabaseTerminalPressureRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  TerminalPressure? _singleTerminalPressure(List<Map<String, dynamic>> data) {
    if (data.isEmpty) return null;
    return TerminalPressure.fromJson(data.first);
  }

  @override
  Stream<TerminalPressure?> watchTerminalPressure(String collectorId) {
    final stream = _supabaseClient.terminalPressureStream
        .eq(TerminalPressureDatabaseKeys.collectorId, collectorId)
        .order(TerminalPressureDatabaseKeys.createdAt, ascending: false)
        .limit(1);

    return stream.map(_singleTerminalPressure);
  }
}
