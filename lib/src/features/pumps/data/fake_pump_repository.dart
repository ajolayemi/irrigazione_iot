import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/config/mock/fake_pumps.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/domain/pump.dart';
import 'package:irrigazione_iot/src/utils/delay.dart';
import 'package:irrigazione_iot/src/utils/in_memory_store.dart';

class FakePumpRepository implements PumpRepository {
  FakePumpRepository({this.addDelay = true});
  final bool addDelay;
  final _fakePumps = InMemoryStore<List<Pump>>(kFakePumps);

  static List<Pump> _getCompanyPumps(List<Pump> pumps, String companyId) {
    return pumps.where((pump) => pump.companyId == companyId).toList();
  }

  static Pump? _getPump(List<Pump> pumps, String pumpId) {
    try {
      return pumps.firstWhere((pump) => pump.id == pumpId);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Pump>> getCompanyPumps(String companyId) async {
    await delay(true);
    return Future.value(_getCompanyPumps(_fakePumps.value, companyId));
  }

  @override
  Stream<List<Pump>> watchCompanyPumps(String companyId) {
    return _fakePumps.stream.map((pumps) => _getCompanyPumps(pumps, companyId));
  }

  @override
  Future<Pump?> getPump(String pumpId) async {
    await delay(true);
    return Future.value(_getPump(_fakePumps.value, pumpId));
  }

  @override
  Stream<Pump?> watchPump(String pumpId) {
    return _fakePumps.stream.map((pumps) => _getPump(pumps, pumpId));
  }

  @override
  Future<Pump?> createPump(Pump pump) async {
    await delay(true);
    debugPrint("creating pump");
    return Future.value(null);
  }

  @override
  Future<Pump?> updatePump(Pump pump) async {
    await delay(true);
    return Future.value(null);
  }
}
