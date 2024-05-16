import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/data/supabase_sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'sector_repository.g.dart';

abstract class SectorRepository {
  /// emits a list of sectors pertaining to a company
  Stream<List<Sector?>> watchSectors(String companyId);

  /// emits a sector with the given sectorID
  Stream<Sector?> watchSector(String sectorID);

  /// fetches the sector with the given [sectorId]
  Future<Sector?> getSector(String sectorId);

  /// adds a sector
  Future<Sector?> createSector(Sector sector);

  /// updates a sector
  Future<Sector?> updateSector(Sector sector);

  /// deletes a sector
  Future<bool> deleteSector(String sectorID);

  /// emits a list of already used sector names for a specified company
  /// this is used in form validation to prevent duplicate sector names for a company
  Stream<List<String?>> watchCompanyUsedSectorNames(String companyId);

  /// emits a list of already used commands (on and off) for a specified company
  /// this is used in form validation to prevent duplicate commands for a company
  Stream<List<String?>> watchCompanySectorUsedCommands(String companyId);

  /// emits a list of general already used mqtt names
  /// this is used in form validation to prevent duplicate mqtt names
  Stream<List<String?>> watchSectorUsedMqttMsgNames();
}

@Riverpod(keepAlive: true)
SectorRepository sectorRepository(SectorRepositoryRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabaseSectorRepository(supabaseClient);
}

@riverpod
Stream<List<Sector?>> sectorListStream(SectorListStreamRef ref) {
  final sectorsRepository = ref.read(sectorRepositoryProvider);
  final companyId = ref.watch(currentTappedCompanyProvider).valueOrNull?.id;
  if (companyId == null) return Stream.value([]);
  return sectorsRepository.watchSectors(companyId);
}

@riverpod
Stream<Sector?> sectorStream(SectorStreamRef ref, String sectorID) {
  final sectorsRepository = ref.read(sectorRepositoryProvider);
  return sectorsRepository.watchSector(sectorID);
}

@riverpod
Future<Sector?> sectorFuture(SectorFutureRef ref, String sectorID) {
  final sectorsRepository = ref.read(sectorRepositoryProvider);
  return sectorsRepository.getSector(sectorID);
}

@riverpod
Stream<List<String?>> usedSectorNamesStream(UsedSectorNamesStreamRef ref) {
  final sectorsRepository = ref.read(sectorRepositoryProvider);
  final currentSelectedCompanyByUser =
      ref.read(currentTappedCompanyProvider).valueOrNull;
  if (currentSelectedCompanyByUser == null) return Stream.value([]);
  return sectorsRepository
      .watchCompanyUsedSectorNames(currentSelectedCompanyByUser.id);
}

@riverpod
Stream<List<String?>> usedSectorCommandsStream(UsedSectorCommandsStreamRef ref) {
  final sectorsRepository = ref.read(sectorRepositoryProvider);
  final currentSelectedCompanyByUser =
      ref.read(currentTappedCompanyProvider).valueOrNull;
  if (currentSelectedCompanyByUser == null) return Stream.value([]);
  return sectorsRepository
      .watchCompanySectorUsedCommands(currentSelectedCompanyByUser.id);
}

@riverpod
Stream<List<String?>> sectorUsedMqttMessageNamesStream(
    SectorUsedMqttMessageNamesStreamRef ref) {
  final sectorsRepository = ref.read(sectorRepositoryProvider);
  return sectorsRepository.watchSectorUsedMqttMsgNames();
}
