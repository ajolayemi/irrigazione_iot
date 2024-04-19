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
String _$sectorLastPressureStreamHash() =>
    r'15073320b18aae2f0fabb1529094fde4f6a34f4d';

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

/// See also [sectorLastPressureStream].
@ProviderFor(sectorLastPressureStream)
const sectorLastPressureStreamProvider = SectorLastPressureStreamFamily();

/// See also [sectorLastPressureStream].
class SectorLastPressureStreamFamily extends Family<AsyncValue<DateTime?>> {
  /// See also [sectorLastPressureStream].
  const SectorLastPressureStreamFamily();

  /// See also [sectorLastPressureStream].
  SectorLastPressureStreamProvider call(
    String sectorId,
  ) {
    return SectorLastPressureStreamProvider(
      sectorId,
    );
  }

  @override
  SectorLastPressureStreamProvider getProviderOverride(
    covariant SectorLastPressureStreamProvider provider,
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
  String? get name => r'sectorLastPressureStreamProvider';
}

/// See also [sectorLastPressureStream].
class SectorLastPressureStreamProvider
    extends AutoDisposeStreamProvider<DateTime?> {
  /// See also [sectorLastPressureStream].
  SectorLastPressureStreamProvider(
    String sectorId,
  ) : this._internal(
          (ref) => sectorLastPressureStream(
            ref as SectorLastPressureStreamRef,
            sectorId,
          ),
          from: sectorLastPressureStreamProvider,
          name: r'sectorLastPressureStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sectorLastPressureStreamHash,
          dependencies: SectorLastPressureStreamFamily._dependencies,
          allTransitiveDependencies:
              SectorLastPressureStreamFamily._allTransitiveDependencies,
          sectorId: sectorId,
        );

  SectorLastPressureStreamProvider._internal(
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
    Stream<DateTime?> Function(SectorLastPressureStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SectorLastPressureStreamProvider._internal(
        (ref) => create(ref as SectorLastPressureStreamRef),
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
    return _SectorLastPressureStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SectorLastPressureStreamProvider &&
        other.sectorId == sectorId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sectorId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SectorLastPressureStreamRef on AutoDisposeStreamProviderRef<DateTime?> {
  /// The parameter `sectorId` of this provider.
  String get sectorId;
}

class _SectorLastPressureStreamProviderElement
    extends AutoDisposeStreamProviderElement<DateTime?>
    with SectorLastPressureStreamRef {
  _SectorLastPressureStreamProviderElement(super.provider);

  @override
  String get sectorId => (origin as SectorLastPressureStreamProvider).sectorId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
