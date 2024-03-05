// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sector_status_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sectorStatusRepositoryHash() =>
    r'6d865506ada01bd984405108d839f51bb6117621';

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
    r'06d6aa9f0b952ace8d4e79fb297a06c6e7baab33';

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
class SectorStatusStreamFamily extends Family<AsyncValue<SectorStatus?>> {
  /// See also [sectorStatusStream].
  const SectorStatusStreamFamily();

  /// See also [sectorStatusStream].
  SectorStatusStreamProvider call(
    String sectorID,
  ) {
    return SectorStatusStreamProvider(
      sectorID,
    );
  }

  @override
  SectorStatusStreamProvider getProviderOverride(
    covariant SectorStatusStreamProvider provider,
  ) {
    return call(
      provider.sectorID,
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
class SectorStatusStreamProvider
    extends AutoDisposeStreamProvider<SectorStatus?> {
  /// See also [sectorStatusStream].
  SectorStatusStreamProvider(
    String sectorID,
  ) : this._internal(
          (ref) => sectorStatusStream(
            ref as SectorStatusStreamRef,
            sectorID,
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
          sectorID: sectorID,
        );

  SectorStatusStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.sectorID,
  }) : super.internal();

  final String sectorID;

  @override
  Override overrideWith(
    Stream<SectorStatus?> Function(SectorStatusStreamRef provider) create,
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
        sectorID: sectorID,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<SectorStatus?> createElement() {
    return _SectorStatusStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SectorStatusStreamProvider && other.sectorID == sectorID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sectorID.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SectorStatusStreamRef on AutoDisposeStreamProviderRef<SectorStatus?> {
  /// The parameter `sectorID` of this provider.
  String get sectorID;
}

class _SectorStatusStreamProviderElement
    extends AutoDisposeStreamProviderElement<SectorStatus?>
    with SectorStatusStreamRef {
  _SectorStatusStreamProviderElement(super.provider);

  @override
  String get sectorID => (origin as SectorStatusStreamProvider).sectorID;
}

String _$sectorStatusFutureHash() =>
    r'85c8f6fea567e928ac7e6925c37c82333b086ba6';

/// See also [sectorStatusFuture].
@ProviderFor(sectorStatusFuture)
const sectorStatusFutureProvider = SectorStatusFutureFamily();

/// See also [sectorStatusFuture].
class SectorStatusFutureFamily extends Family<AsyncValue<SectorStatus?>> {
  /// See also [sectorStatusFuture].
  const SectorStatusFutureFamily();

  /// See also [sectorStatusFuture].
  SectorStatusFutureProvider call(
    String sectorID,
  ) {
    return SectorStatusFutureProvider(
      sectorID,
    );
  }

  @override
  SectorStatusFutureProvider getProviderOverride(
    covariant SectorStatusFutureProvider provider,
  ) {
    return call(
      provider.sectorID,
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
  String? get name => r'sectorStatusFutureProvider';
}

/// See also [sectorStatusFuture].
class SectorStatusFutureProvider
    extends AutoDisposeFutureProvider<SectorStatus?> {
  /// See also [sectorStatusFuture].
  SectorStatusFutureProvider(
    String sectorID,
  ) : this._internal(
          (ref) => sectorStatusFuture(
            ref as SectorStatusFutureRef,
            sectorID,
          ),
          from: sectorStatusFutureProvider,
          name: r'sectorStatusFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sectorStatusFutureHash,
          dependencies: SectorStatusFutureFamily._dependencies,
          allTransitiveDependencies:
              SectorStatusFutureFamily._allTransitiveDependencies,
          sectorID: sectorID,
        );

  SectorStatusFutureProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.sectorID,
  }) : super.internal();

  final String sectorID;

  @override
  Override overrideWith(
    FutureOr<SectorStatus?> Function(SectorStatusFutureRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SectorStatusFutureProvider._internal(
        (ref) => create(ref as SectorStatusFutureRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        sectorID: sectorID,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<SectorStatus?> createElement() {
    return _SectorStatusFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SectorStatusFutureProvider && other.sectorID == sectorID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sectorID.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SectorStatusFutureRef on AutoDisposeFutureProviderRef<SectorStatus?> {
  /// The parameter `sectorID` of this provider.
  String get sectorID;
}

class _SectorStatusFutureProviderElement
    extends AutoDisposeFutureProviderElement<SectorStatus?>
    with SectorStatusFutureRef {
  _SectorStatusFutureProviderElement(super.provider);

  @override
  String get sectorID => (origin as SectorStatusFutureProvider).sectorID;
}

String _$watchSectorLastIrrigationHash() =>
    r'5c7f2e04c40ee5034f6136b86ea46abf3793d703';

/// See also [watchSectorLastIrrigation].
@ProviderFor(watchSectorLastIrrigation)
const watchSectorLastIrrigationProvider = WatchSectorLastIrrigationFamily();

/// See also [watchSectorLastIrrigation].
class WatchSectorLastIrrigationFamily extends Family<AsyncValue<DateTime?>> {
  /// See also [watchSectorLastIrrigation].
  const WatchSectorLastIrrigationFamily();

  /// See also [watchSectorLastIrrigation].
  WatchSectorLastIrrigationProvider call(
    Sector sector,
  ) {
    return WatchSectorLastIrrigationProvider(
      sector,
    );
  }

  @override
  WatchSectorLastIrrigationProvider getProviderOverride(
    covariant WatchSectorLastIrrigationProvider provider,
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
  String? get name => r'watchSectorLastIrrigationProvider';
}

/// See also [watchSectorLastIrrigation].
class WatchSectorLastIrrigationProvider
    extends AutoDisposeStreamProvider<DateTime?> {
  /// See also [watchSectorLastIrrigation].
  WatchSectorLastIrrigationProvider(
    Sector sector,
  ) : this._internal(
          (ref) => watchSectorLastIrrigation(
            ref as WatchSectorLastIrrigationRef,
            sector,
          ),
          from: watchSectorLastIrrigationProvider,
          name: r'watchSectorLastIrrigationProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$watchSectorLastIrrigationHash,
          dependencies: WatchSectorLastIrrigationFamily._dependencies,
          allTransitiveDependencies:
              WatchSectorLastIrrigationFamily._allTransitiveDependencies,
          sector: sector,
        );

  WatchSectorLastIrrigationProvider._internal(
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
    Stream<DateTime?> Function(WatchSectorLastIrrigationRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WatchSectorLastIrrigationProvider._internal(
        (ref) => create(ref as WatchSectorLastIrrigationRef),
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
  AutoDisposeStreamProviderElement<DateTime?> createElement() {
    return _WatchSectorLastIrrigationProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WatchSectorLastIrrigationProvider && other.sector == sector;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sector.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WatchSectorLastIrrigationRef on AutoDisposeStreamProviderRef<DateTime?> {
  /// The parameter `sector` of this provider.
  Sector get sector;
}

class _WatchSectorLastIrrigationProviderElement
    extends AutoDisposeStreamProviderElement<DateTime?>
    with WatchSectorLastIrrigationRef {
  _WatchSectorLastIrrigationProviderElement(super.provider);

  @override
  Sector get sector => (origin as WatchSectorLastIrrigationProvider).sector;
}

String _$getSectorLastIrrigationHash() =>
    r'9e5605042e3ace917663a41415d2bd2d7c53d228';

/// See also [getSectorLastIrrigation].
@ProviderFor(getSectorLastIrrigation)
const getSectorLastIrrigationProvider = GetSectorLastIrrigationFamily();

/// See also [getSectorLastIrrigation].
class GetSectorLastIrrigationFamily extends Family<AsyncValue<DateTime?>> {
  /// See also [getSectorLastIrrigation].
  const GetSectorLastIrrigationFamily();

  /// See also [getSectorLastIrrigation].
  GetSectorLastIrrigationProvider call(
    Sector sector,
  ) {
    return GetSectorLastIrrigationProvider(
      sector,
    );
  }

  @override
  GetSectorLastIrrigationProvider getProviderOverride(
    covariant GetSectorLastIrrigationProvider provider,
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
  String? get name => r'getSectorLastIrrigationProvider';
}

/// See also [getSectorLastIrrigation].
class GetSectorLastIrrigationProvider
    extends AutoDisposeFutureProvider<DateTime?> {
  /// See also [getSectorLastIrrigation].
  GetSectorLastIrrigationProvider(
    Sector sector,
  ) : this._internal(
          (ref) => getSectorLastIrrigation(
            ref as GetSectorLastIrrigationRef,
            sector,
          ),
          from: getSectorLastIrrigationProvider,
          name: r'getSectorLastIrrigationProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getSectorLastIrrigationHash,
          dependencies: GetSectorLastIrrigationFamily._dependencies,
          allTransitiveDependencies:
              GetSectorLastIrrigationFamily._allTransitiveDependencies,
          sector: sector,
        );

  GetSectorLastIrrigationProvider._internal(
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
    FutureOr<DateTime?> Function(GetSectorLastIrrigationRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetSectorLastIrrigationProvider._internal(
        (ref) => create(ref as GetSectorLastIrrigationRef),
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
  AutoDisposeFutureProviderElement<DateTime?> createElement() {
    return _GetSectorLastIrrigationProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetSectorLastIrrigationProvider && other.sector == sector;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sector.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetSectorLastIrrigationRef on AutoDisposeFutureProviderRef<DateTime?> {
  /// The parameter `sector` of this provider.
  Sector get sector;
}

class _GetSectorLastIrrigationProviderElement
    extends AutoDisposeFutureProviderElement<DateTime?>
    with GetSectorLastIrrigationRef {
  _GetSectorLastIrrigationProviderElement(super.provider);

  @override
  Sector get sector => (origin as GetSectorLastIrrigationProvider).sector;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
