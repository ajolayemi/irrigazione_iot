// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sector_pressure_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sectorPressureRepositoryHash() =>
    r'9571e64ffacaeb64650a397af1974fc7e1400294';

/// See also [sectorPressureRepository].
@ProviderFor(sectorPressureRepository)
final sectorPressureRepositoryProvider =
    Provider<SectorPressureRepository>.internal(
  sectorPressureRepository,
  name: r'sectorPressureRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sectorPressureRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SectorPressureRepositoryRef = ProviderRef<SectorPressureRepository>;
String _$sectorPressureStreamHash() =>
    r'40148a2c3ede827214c621121549aec948723d55';

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

/// See also [sectorPressureStream].
@ProviderFor(sectorPressureStream)
const sectorPressureStreamProvider = SectorPressureStreamFamily();

/// See also [sectorPressureStream].
class SectorPressureStreamFamily extends Family<AsyncValue<DateTime?>> {
  /// See also [sectorPressureStream].
  const SectorPressureStreamFamily();

  /// See also [sectorPressureStream].
  SectorPressureStreamProvider call(
    String sectorId,
  ) {
    return SectorPressureStreamProvider(
      sectorId,
    );
  }

  @override
  SectorPressureStreamProvider getProviderOverride(
    covariant SectorPressureStreamProvider provider,
  ) {
    return call(
      provider.sectorId,
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
  String? get name => r'sectorPressureStreamProvider';
}

/// See also [sectorPressureStream].
class SectorPressureStreamProvider
    extends AutoDisposeStreamProvider<DateTime?> {
  /// See also [sectorPressureStream].
  SectorPressureStreamProvider(
    String sectorId,
  ) : this._internal(
          (ref) => sectorPressureStream(
            ref as SectorPressureStreamRef,
            sectorId,
          ),
          from: sectorPressureStreamProvider,
          name: r'sectorPressureStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sectorPressureStreamHash,
          dependencies: SectorPressureStreamFamily._dependencies,
          allTransitiveDependencies:
              SectorPressureStreamFamily._allTransitiveDependencies,
          sectorId: sectorId,
        );

  SectorPressureStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.sectorId,
  }) : super.internal();

  final String sectorId;

  @override
  Override overrideWith(
    Stream<DateTime?> Function(SectorPressureStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SectorPressureStreamProvider._internal(
        (ref) => create(ref as SectorPressureStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        sectorId: sectorId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<DateTime?> createElement() {
    return _SectorPressureStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SectorPressureStreamProvider && other.sectorId == sectorId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sectorId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SectorPressureStreamRef on AutoDisposeStreamProviderRef<DateTime?> {
  /// The parameter `sectorId` of this provider.
  String get sectorId;
}

class _SectorPressureStreamProviderElement
    extends AutoDisposeStreamProviderElement<DateTime?>
    with SectorPressureStreamRef {
  _SectorPressureStreamProviderElement(super.provider);

  @override
  String get sectorId => (origin as SectorPressureStreamProvider).sectorId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
