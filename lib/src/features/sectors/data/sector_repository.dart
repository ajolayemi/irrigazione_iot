import 'dart:async';

import 'package:irrigazione_iot/src/features/sectors/data/fake_sectors_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/domain/sector.dart';
import 'package:irrigazione_iot/src/features/user_companies/domain/company.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sector_repository.g.dart';

abstract class SectorsRepository {
  Future<List<Sector?>> fetchSectors(CompanyID companyId);
  Stream<List<Sector?>> watchSectors(CompanyID companyId);
  Stream<Sector?> watchSector(SectorID sectorID);
  Future<Sector?> fetchSector(SectorID sectorID);
  Future<void> addSector(Sector sector, CompanyID companyId);
  Future<void> updateSector(SectorID sectorID);
  Future<void> deleteSector(SectorID sectorID);
}

@Riverpod(keepAlive: true)
SectorsRepository sectorsRepository(SectorsRepositoryRef ref) {
  // todo return remote repository as default
  return FakeSectorsRepository();
}


@riverpod
Stream<List<Sector?>> sectorListStream(SectorListStreamRef ref, CompanyID companyId) {
  final sectorsRepository = ref.read(sectorsRepositoryProvider);
  return sectorsRepository.watchSectors(companyId);
}

@riverpod
Future<List<Sector?>> sectorListFuture(SectorListFutureRef ref, CompanyID companyId) {
  final sectorsRepository = ref.read(sectorsRepositoryProvider);
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