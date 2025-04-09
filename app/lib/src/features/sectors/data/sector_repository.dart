import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/data/supabase_sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'sector_repository.g.dart';

abstract class SectorRepository {
  /// Fetches a list of [Sector]s pertaining to a company
  Future<List<Sector>?> getCompanySectors(String companyId);

  /// Fetches a list of all [Sector]s in the database
  Future<List<Sector>?> getAllSectors();

  /// fetches the [Sector] with the given [sectorId]
  Future<Sector?> getSector(String sectorId);

  /// adds a [Sector]
  Future<Sector?> createSector(Sector sector);

  /// updates a [Sector]
  Future<Sector?> updateSector(Sector sector);

  /// deletes a [Sector]
  Future<bool> deleteSector(String sectorID);

  /// Fetches list of already used sector names for a specified company
  /// this is used in form validation to prevent duplicate sector names for a company
  Future<List<String?>> getCompanyUsedSectorNames(String companyId);

  /// Fetches list of already used commands (on and off) for a specified company
  /// this is used in form validation to prevent duplicate commands for a company
  Future<List<String?>> getCompanySectorUsedCommands(String companyId);

  /// Fetches list of general already used mqtt names
  /// this is used in form validation to prevent duplicate mqtt names
  Future<List<String?>> getSectorUsedMqttMsgNames();
}

@Riverpod(keepAlive: true)
SectorRepository sectorRepository(Ref ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabaseSectorRepository(supabaseClient);
}

/// Fetches the list of sectors for the current company
@Riverpod(keepAlive: true)
Future<List<Sector>?> sectors(Ref ref) {
  final sectorsRepository = ref.read(sectorRepositoryProvider);
  final companyId = ref.watch(currentTappedCompanyProvider).valueOrNull?.id;
  if (companyId == null) return Future.value([]);
  return sectorsRepository.getCompanySectors(companyId);
}

@riverpod
Future<List<Sector>?> allSectorsFuture(Ref ref) {
  final sectorsRepository = ref.read(sectorRepositoryProvider);
  return sectorsRepository.getAllSectors();
}



@Riverpod(keepAlive: true)
FutureOr<Sector?> sector(Ref ref, String sectorID) {
  final sectorsRepository = ref.watch(sectorRepositoryProvider);
  return sectorsRepository.getSector(sectorID);
}

@riverpod
Future<List<String?>> usedSectorNamesFuture(Ref ref) {
  final sectorsRepository = ref.read(sectorRepositoryProvider);
  final currentSelectedCompanyByUser =
      ref.read(currentTappedCompanyProvider).valueOrNull;
  if (currentSelectedCompanyByUser == null) return Future.value([]);
  return sectorsRepository
      .getCompanyUsedSectorNames(currentSelectedCompanyByUser.id);
}

@riverpod
Future<List<String?>> usedSectorCommandsFuture(
    Ref ref) {
  final sectorsRepository = ref.read(sectorRepositoryProvider);
  final currentSelectedCompanyByUser =
      ref.read(currentTappedCompanyProvider).valueOrNull;
  if (currentSelectedCompanyByUser == null) return Future.value([]);
  return sectorsRepository
      .getCompanySectorUsedCommands(currentSelectedCompanyByUser.id);
}

@riverpod
Future<List<String?>> sectorUsedMqttMessageNamesFuture(
    Ref ref) {
  final sectorsRepository = ref.read(sectorRepositoryProvider);
  return sectorsRepository.getSectorUsedMqttMsgNames();
}
