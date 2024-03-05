// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sector_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sectorsRepositoryHash() => r'bd90b585bac3b557dd60f33e115efd7357069770';

/// See also [sectorsRepository].
@ProviderFor(sectorsRepository)
final sectorsRepositoryProvider = Provider<SectorsRepository>.internal(
  sectorsRepository,
  name: r'sectorsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sectorsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SectorsRepositoryRef = ProviderRef<SectorsRepository>;
String _$sectorListStreamHash() => r'9ebc2e02001b5c3a2f716d29099935bed91b7531';

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

/// See also [sectorListStream].
@ProviderFor(sectorListStream)
const sectorListStreamProvider = SectorListStreamFamily();

/// See also [sectorListStream].
class SectorListStreamFamily extends Family<AsyncValue<List<Sector?>>> {
  /// See also [sectorListStream].
  const SectorListStreamFamily();

  /// See also [sectorListStream].
  SectorListStreamProvider call(
    String companyId,
  ) {
    return SectorListStreamProvider(
      companyId,
    );
  }

  @override
  SectorListStreamProvider getProviderOverride(
    covariant SectorListStreamProvider provider,
  ) {
    return call(
      provider.companyId,
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
  String? get name => r'sectorListStreamProvider';
}

/// See also [sectorListStream].
class SectorListStreamProvider
    extends AutoDisposeStreamProvider<List<Sector?>> {
  /// See also [sectorListStream].
  SectorListStreamProvider(
    String companyId,
  ) : this._internal(
          (ref) => sectorListStream(
            ref as SectorListStreamRef,
            companyId,
          ),
          from: sectorListStreamProvider,
          name: r'sectorListStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sectorListStreamHash,
          dependencies: SectorListStreamFamily._dependencies,
          allTransitiveDependencies:
              SectorListStreamFamily._allTransitiveDependencies,
          companyId: companyId,
        );

  SectorListStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.companyId,
  }) : super.internal();

  final String companyId;

  @override
  Override overrideWith(
    Stream<List<Sector?>> Function(SectorListStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SectorListStreamProvider._internal(
        (ref) => create(ref as SectorListStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        companyId: companyId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Sector?>> createElement() {
    return _SectorListStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SectorListStreamProvider && other.companyId == companyId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, companyId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SectorListStreamRef on AutoDisposeStreamProviderRef<List<Sector?>> {
  /// The parameter `companyId` of this provider.
  String get companyId;
}

class _SectorListStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<Sector?>>
    with SectorListStreamRef {
  _SectorListStreamProviderElement(super.provider);

  @override
  String get companyId => (origin as SectorListStreamProvider).companyId;
}

String _$sectorListFutureHash() => r'c1f87ab5a014542c8bb9be11fb840c9409e39bd0';

/// See also [sectorListFuture].
@ProviderFor(sectorListFuture)
const sectorListFutureProvider = SectorListFutureFamily();

/// See also [sectorListFuture].
class SectorListFutureFamily extends Family<AsyncValue<List<Sector?>>> {
  /// See also [sectorListFuture].
  const SectorListFutureFamily();

  /// See also [sectorListFuture].
  SectorListFutureProvider call(
    String companyId,
  ) {
    return SectorListFutureProvider(
      companyId,
    );
  }

  @override
  SectorListFutureProvider getProviderOverride(
    covariant SectorListFutureProvider provider,
  ) {
    return call(
      provider.companyId,
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
  String? get name => r'sectorListFutureProvider';
}

/// See also [sectorListFuture].
class SectorListFutureProvider
    extends AutoDisposeFutureProvider<List<Sector?>> {
  /// See also [sectorListFuture].
  SectorListFutureProvider(
    String companyId,
  ) : this._internal(
          (ref) => sectorListFuture(
            ref as SectorListFutureRef,
            companyId,
          ),
          from: sectorListFutureProvider,
          name: r'sectorListFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sectorListFutureHash,
          dependencies: SectorListFutureFamily._dependencies,
          allTransitiveDependencies:
              SectorListFutureFamily._allTransitiveDependencies,
          companyId: companyId,
        );

  SectorListFutureProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.companyId,
  }) : super.internal();

  final String companyId;

  @override
  Override overrideWith(
    FutureOr<List<Sector?>> Function(SectorListFutureRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SectorListFutureProvider._internal(
        (ref) => create(ref as SectorListFutureRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        companyId: companyId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Sector?>> createElement() {
    return _SectorListFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SectorListFutureProvider && other.companyId == companyId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, companyId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SectorListFutureRef on AutoDisposeFutureProviderRef<List<Sector?>> {
  /// The parameter `companyId` of this provider.
  String get companyId;
}

class _SectorListFutureProviderElement
    extends AutoDisposeFutureProviderElement<List<Sector?>>
    with SectorListFutureRef {
  _SectorListFutureProviderElement(super.provider);

  @override
  String get companyId => (origin as SectorListFutureProvider).companyId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
