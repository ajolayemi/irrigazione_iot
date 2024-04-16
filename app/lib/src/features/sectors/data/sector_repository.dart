import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/data/supabase_sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'sector_repository.g.dart';

abstract class SectorRepository {
  // returns a list of sectors pertaining to a company
  Future<List<Sector?>> getSectors(String companyId);
  // emits a list of sectors pertaining to a company
  Stream<List<Sector?>> watchSectors(String companyId);
  // emits a sector with the given sectorID
  Stream<Sector?> watchSector(String sectorID);
  // returns a sector with the given sectorID
  Future<Sector?> getSector(String sectorID);
  // adds a sector
  Future<Sector?> addSector(Sector sector, String companyId);
  // updates a sector
  Future<Sector?> updateSector(Sector sector, String companyId);
  // deletes a sector
  Future<bool> deleteSector(String sectorID);
  // emits a list of already used sector names for a specified company
  // this is used in form validation to prevent duplicate sector names for a company
  Stream<List<String?>> watchCompanyUsedSectorNames(String companyId);
  // emits a list of already used sector on commands for a specified company
  // this is used in form validation to prevent duplicate sector on commands for a company
  Stream<List<String?>> watchCompanyUsedSectorOnCommands(String companyId);
  // emits a list of already used sector off commands for a specified company
  // this is used in form validation to prevent duplicate sector off commands for a company
  Stream<List<String?>> watchCompanyUsedSectorOffCommands(String companyId);
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
  if (companyId == null) return const Stream.empty();
  return sectorsRepository.watchSectors(companyId);
}

@riverpod
Future<List<Sector?>> sectorListFuture(SectorListFutureRef ref) {
  final sectorsRepository = ref.read(sectorRepositoryProvider);
  final companyId = ref.watch(currentTappedCompanyProvider).valueOrNull?.id;
  if (companyId == null) return Future.value([]);
  return sectorsRepository.getSectors(companyId);
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
  if (currentSelectedCompanyByUser == null) return const Stream.empty();
  return sectorsRepository
      .watchCompanyUsedSectorNames(currentSelectedCompanyByUser.id);
}

@riverpod
Stream<List<String?>> usedSectorOnCommandsStream(
    UsedSectorOnCommandsStreamRef ref) {
  final sectorsRepository = ref.read(sectorRepositoryProvider);
  final currentSelectedCompanyByUser =
      ref.read(currentTappedCompanyProvider).valueOrNull;
  if (currentSelectedCompanyByUser == null) return const Stream.empty();
  return sectorsRepository
      .watchCompanyUsedSectorOnCommands(currentSelectedCompanyByUser.id);
}

@riverpod
Stream<List<String?>> usedSectorOffCommandsStream(
    UsedSectorOffCommandsStreamRef ref) {
  final sectorsRepository = ref.read(sectorRepositoryProvider);
  final currentSelectedCompanyByUser =
      ref.read(currentTappedCompanyProvider).valueOrNull;
  if (currentSelectedCompanyByUser == null) return const Stream.empty();
  return sectorsRepository
      .watchCompanyUsedSectorOffCommands(currentSelectedCompanyByUser.id);
}
