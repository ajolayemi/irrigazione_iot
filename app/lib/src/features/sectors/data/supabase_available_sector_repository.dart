import 'package:irrigazione_iot/src/features/sectors/data/available_sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/model/available_sector.dart';
import 'package:irrigazione_iot/src/features/sectors/model/available_sector_database_keys.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAvailableSectorRepository implements AvailableSectorRepository {
  const SupabaseAvailableSectorRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  @override
  Stream<List<AvailableSector>?> watchAvailableSectors(
    String companyId, {
    List<AvailableSector>? sectorsAlreadyConnectedToCollector,
  }) {
    final stream =
        _supabaseClient.from(AvailableSectorDatabaseKeys.table).stream(
      primaryKey: [AvailableSectorDatabaseKeys.id],
    ).eq(
      AvailableSectorDatabaseKeys.companyId,
      companyId,
    );

    return stream.map((data) {
      if (data.isEmpty) return null;
      final mappedData = data.map((e) => AvailableSector.fromJson(e)).toList();
      if (sectorsAlreadyConnectedToCollector == null) return mappedData;
      return [...mappedData, ...sectorsAlreadyConnectedToCollector];
    });
  }
}
