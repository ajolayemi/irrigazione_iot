// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pump_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pumpRepositoryHash() => r'deb88bf39190b9957baae097097f7ad5f62ef4f2';

/// See also [pumpRepository].
@ProviderFor(pumpRepository)
final pumpRepositoryProvider = Provider<PumpRepository>.internal(
  pumpRepository,
  name: r'pumpRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pumpRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PumpRepositoryRef = ProviderRef<PumpRepository>;
String _$companyPumpsStreamHash() =>
    r'f13a14444cfa7d67183b6767bee8cea2adb937b8';

/// See also [companyPumpsStream].
@ProviderFor(companyPumpsStream)
final companyPumpsStreamProvider =
    AutoDisposeStreamProvider<List<Pump>>.internal(
  companyPumpsStream,
  name: r'companyPumpsStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$companyPumpsStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CompanyPumpsStreamRef = AutoDisposeStreamProviderRef<List<Pump>>;
String _$companyPumpsFutureHash() =>
    r'0ac3a9f7d22a3ef8cf03a1925c192f73692fc043';

/// See also [companyPumpsFuture].
@ProviderFor(companyPumpsFuture)
final companyPumpsFutureProvider =
    AutoDisposeFutureProvider<List<Pump>>.internal(
  companyPumpsFuture,
  name: r'companyPumpsFutureProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$companyPumpsFutureHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CompanyPumpsFutureRef = AutoDisposeFutureProviderRef<List<Pump>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
