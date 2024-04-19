// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sector_status_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sectorStatusRepositoryHash() =>
    r'63297971576bdc468cde624716a79a8ce30a2e88';

/// See also [sectorStatusRepository].
@ProviderFor(sectorStatusRepository)
final sectorStatusRepositoryProvider =
    Provider<SectorStatusRepository>.internal(
  sectorStatusRepository,
  name: r'sectorStatusRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sectorStatusRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SectorStatusRepositoryRef = ProviderRef<SectorStatusRepository>;
String _$sectorStatusStreamHash() =>
    r'e4fbc0f00dec5df0777767fc5b5ba32ffe726624';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [sectorStatusStream].
@ProviderFor(sectorStatusStream)
const sectorStatusStreamProvider = SectorStatusStreamFamily();

/// See also [sectorStatusStream].
class SectorStatusStreamFamily extends Family<AsyncValue<bool?>> {
  /// See also [sectorStatusStream].
  const SectorStatusStreamFamily();

  /// See also [sectorStatusStream].
  SectorStatusStreamProvider call(
    Sector sector,
  ) {
    return SectorStatusStreamProvider(
      sector,
    );
  }

  @override
  SectorStatusStreamProvider getProviderOverride(
    covariant SectorStatusStreamProvider provider,
  ) {
    return call(
      provider.sector,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'sectorStatusStreamProvider';
}

/// See also [sectorStatusStream].
class SectorStatusStreamProvider extends AutoDisposeStreamProvider<bool?> {
  /// See also [sectorStatusStream].
  SectorStatusStreamProvider(
    Sector sector,
  ) : this._internal(
          (ref) => sectorStatusStream(
            ref as SectorStatusStreamRef,
            sector,
          ),
          from: sectorStatusStreamProvider,
          name: r'sectorStatusStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sectorStatusStreamHash,
          dependencies: SectorStatusStreamFamily._dependencies,
          allTransitiveDependencies:
              SectorStatusStreamFamily._allTransitiveDependencies,
          sector: sector,
        );

  SectorStatusStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.sector,
  }) : super.internal();

  final Sector sector;

  @override
  Override overrideWith(
    Stream<bool?> Function(SectorStatusStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SectorStatusStreamProvider._internal(
        (ref) => create(ref as SectorStatusStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        sector: sector,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<bool?> createElement() {
    return _SectorStatusStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SectorStatusStreamProvider && other.sector == sector;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sector.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SectorStatusStreamRef on AutoDisposeStreamProviderRef<bool?> {
  /// The parameter `sector` of this provider.
  Sector get sector;
}

class _SectorStatusStreamProviderElement
    extends AutoDisposeStreamProviderElement<bool?> with SectorStatusStreamRef {
  _SectorStatusStreamProviderElement(super.provider);

  @override
  Sector get sector => (origin as SectorStatusStreamProvider).sector;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
