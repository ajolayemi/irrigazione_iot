import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';

class SupabasePumpRepository implements PumpRepository {

  const SupabasePumpRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  @override
  Future<Pump?> createPump(Pump pump, String companyId) {
    // TODO: implement createPump
    throw UnimplementedError();
  }

  @override
  Future<bool> deletePump(String pumpId) {
    // TODO: implement deletePump
    throw UnimplementedError();
  }

  @override
  Future<List<Pump?>> getCompanyPumps(String companyId) {
    // TODO: implement getCompanyPumps
    throw UnimplementedError();
  }

  @override
  Future<Pump?> getPump(String pumpId) {
    // TODO: implement getPump
    throw UnimplementedError();
  }

  @override
  Future<Pump?> updatePump(Pump pump, String companyId) {
    // TODO: implement updatePump
    throw UnimplementedError();
  }

  @override
  Stream<List<Pump?>> watchCompanyPumps(String companyId) {
    // TODO: implement watchCompanyPumps
    throw UnimplementedError();
  }

  @override
  Stream<List<String?>> watchCompanyUsedPumpNames(String companyId) {
    // TODO: implement watchCompanyUsedPumpNames
    throw UnimplementedError();
  }

  @override
  Stream<List<String?>> watchCompanyUsedPumpOffCommands(String companyId) {
    // TODO: implement watchCompanyUsedPumpOffCommands
    throw UnimplementedError();
  }

  @override
  Stream<List<String?>> watchCompanyUsedPumpOnCommands(String companyId) {
    // TODO: implement watchCompanyUsedPumpOnCommands
    throw UnimplementedError();
  }

  @override
  Stream<Pump?> watchPump(String pumpId) {
    // TODO: implement watchPump
    throw UnimplementedError();
  }
}