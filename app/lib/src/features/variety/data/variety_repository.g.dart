// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variety_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$varietyRepositoryHash() => r'cd243160ad9de9259fda501e9b49fcd77fab4c1c';

/// See also [varietyRepository].
@ProviderFor(varietyRepository)
final varietyRepositoryProvider = Provider<VarietyRepository>.internal(
  varietyRepository,
  name: r'varietyRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$varietyRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef VarietyRepositoryRef = ProviderRef<VarietyRepository>;
String _$varietiesStreamHash() => r'9596324dbced73e226570bab83ede821c6acc675';

/// See also [varietiesStream].
@ProviderFor(varietiesStream)
final varietiesStreamProvider =
    AutoDisposeStreamProvider<List<Variety>?>.internal(
  varietiesStream,
  name: r'varietiesStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$varietiesStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef VarietiesStreamRef = AutoDisposeStreamProviderRef<List<Variety>?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
