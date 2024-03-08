import 'dart:async';

import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/features/sectors/data/fake_sectors_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/domain/sector.dart';
import 'package:irrigazione_iot/src/features/user_companies/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/features/user_companies/domain/company.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sector_repository.g.dart';

abstract class SectorsRepository {
  // returns a list of sectors pertaining to a company
  Future<List<Sector?>> fetchSectors(CompanyID companyId);
  // emits a list of sectors pertaining to a company
  Stream<List<Sector?>> watchSectors(CompanyID companyId);
  // emits a sector with the given sectorID
  Stream<Sector?> watchSector(SectorID sectorID);
  // returns a sector with the given sectorID
  Future<Sector?> fetchSector(SectorID sectorID);
  // adds a sector
  Future<Sector?> addSector(Sector sector, CompanyID companyId);
  // updates a sector
  Future<Sector?> updateSector(Sector sector, CompanyID companyId);
  // deletes a sector
  Future<bool> deleteSector(SectorID sectorID);
  // emits a list of already used sector names for a specified company
  // this is used in form validation to prevent duplicate sector names for a company
  Stream<List<String?>> watchCompanyUsedSectorNames(CompanyID companyId);
  // emits a list of already used sector on commands for a specified company
  // this is used in form validation to prevent duplicate sector on commands for a company
  Stream<List<String?>> watchCompanyUsedSectorOnCommands(CompanyID companyId);
  // emits a list of already used sector off commands for a specified company
  // this is used in form validation to prevent duplicate sector off commands for a company
  Stream<List<String?>> watchCompanyUsedSectorOffCommands(CompanyID companyId);
}

@Riverpod(keepAlive: true)
SectorsRepository sectorsRepository(SectorsRepositoryRef ref) {
  // todo return remote repository as default
  return FakeSectorsRepository();
}

@riverpod
Stream<List<Sector?>> sectorListStream(SectorListStreamRef ref) {
  final sectorsRepository = ref.read(sectorsRepositoryProvider);
  final companyId = ref.watch(currentTappedCompanyProvider).valueOrNull?.id;
  debugPrint('company id: $companyId');
  if (companyId == null) return const Stream.empty();
  return sectorsRepository.watchSectors(companyId);
}

@riverpod
Future<List<Sector?>> sectorListFuture(
    SectorListFutureRef ref) {
  final sectorsRepository = ref.read(sectorsRepositoryProvider);
  final companyId = ref.watch(currentTappedCompanyProvider).valueOrNull?.id;
  if (companyId == null) return Future.value([]);
  return sectorsRepository.fetchSectors(companyId);
}

@riverpod
Stream<Sector?> sectorStream(SectorStreamRef ref, SectorID sectorID) {
  final sectorsRepository = ref.read(sectorsRepositoryProvider);
  return sectorsRepository.watchSector(sectorID);
}

@riverpod
Future<Sector?> sectorFuture(SectorFutureRef ref, SectorID sectorID) {
  final sectorsRepository = ref.read(sectorsRepositoryProvider);
  return sectorsRepository.fetchSector(sectorID);
}

@riverpod
Stream<List<String?>> usedSectorNamesStream(UsedSectorNamesStreamRef ref) {
  final sectorsRepository = ref.read(sectorsRepositoryProvider);
  final currentSelectedCompanyByUser =
      ref.read(currentTappedCompanyProvider).valueOrNull;
  if (currentSelectedCompanyByUser == null) return const Stream.empty();
  return sectorsRepository
      .watchCompanyUsedSectorNames(currentSelectedCompanyByUser.id);
}

@riverpod
Stream<List<String?>> usedSectorOnCommandsStream(
    UsedSectorOnCommandsStreamRef ref) {
  final sectorsRepository = ref.read(sectorsRepositoryProvider);
  final currentSelectedCompanyByUser =
      ref.read(currentTappedCompanyProvider).valueOrNull;
  if (currentSelectedCompanyByUser == null) return const Stream.empty();
  return sectorsRepository
      .watchCompanyUsedSectorOnCommands(currentSelectedCompanyByUser.id);
}

@riverpod
Stream<List<String?>> usedSectorOffCommandsStream(
    UsedSectorOffCommandsStreamRef ref) {
  final sectorsRepository = ref.read(sectorsRepositoryProvider);
  final currentSelectedCompanyByUser =
      ref.read(currentTappedCompanyProvider).valueOrNull;
  if (currentSelectedCompanyByUser == null) return const Stream.empty();
  return sectorsRepository
      .watchCompanyUsedSectorOffCommands(currentSelectedCompanyByUser.id);
}
