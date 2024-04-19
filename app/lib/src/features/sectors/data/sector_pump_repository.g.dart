// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sector_pump_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sectorPumpRepositoryHash() =>
    r'8a9e8c7a5ca0a3f21f14614ff83a11d9c1a23fc5';

/// See also [sectorPumpRepository].
@ProviderFor(sectorPumpRepository)
final sectorPumpRepositoryProvider = Provider<SectorPumpRepository>.internal(
  sectorPumpRepository,
  name: r'sectorPumpRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sectorPumpRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SectorPumpRepositoryRef = ProviderRef<SectorPumpRepository>;
String _$sectorPumpsStreamHash() => r'e411abe6ccd35b14609add55297a5944fd886486';

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

/// See also [sectorPumpsStream].
@ProviderFor(sectorPumpsStream)
const sectorPumpsStreamProvider = SectorPumpsStreamFamily();

/// See also [sectorPumpsStream].
class SectorPumpsStreamFamily extends Family<AsyncValue<List<SectorPump?>>> {
  /// See also [sectorPumpsStream].
  const SectorPumpsStreamFamily();

  /// See also [sectorPumpsStream].
  SectorPumpsStreamProvider call(
    String sectorId,
  ) {
    return SectorPumpsStreamProvider(
      sectorId,
    );
  }

  @override
  SectorPumpsStreamProvider getProviderOverride(
    covariant SectorPumpsStreamProvider provider,
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
  String? get name => r'sectorPumpsStreamProvider';
}

/// See also [sectorPumpsStream].
class SectorPumpsStreamProvider
    extends AutoDisposeStreamProvider<List<SectorPump?>> {
  /// See also [sectorPumpsStream].
  SectorPumpsStreamProvider(
    String sectorId,
  ) : this._internal(
          (ref) => sectorPumpsStream(
            ref as SectorPumpsStreamRef,
            sectorId,
          ),
          from: sectorPumpsStreamProvider,
          name: r'sectorPumpsStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sectorPumpsStreamHash,
          dependencies: SectorPumpsStreamFamily._dependencies,
          allTransitiveDependencies:
              SectorPumpsStreamFamily._allTransitiveDependencies,
          sectorId: sectorId,
        );

  SectorPumpsStreamProvider._internal(
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
    Stream<List<SectorPump?>> Function(SectorPumpsStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SectorPumpsStreamProvider._internal(
        (ref) => create(ref as SectorPumpsStreamRef),
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
  AutoDisposeStreamProviderElement<List<SectorPump?>> createElement() {
    return _SectorPumpsStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SectorPumpsStreamProvider && other.sectorId == sectorId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sectorId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SectorPumpsStreamRef on AutoDisposeStreamProviderRef<List<SectorPump?>> {
  /// The parameter `sectorId` of this provider.
  String get sectorId;
}

class _SectorPumpsStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<SectorPump?>>
    with SectorPumpsStreamRef {
  _SectorPumpsStreamProviderElement(super.provider);

  @override
  String get sectorId => (origin as SectorPumpsStreamProvider).sectorId;
}

String _$sectorPumpsFutureHash() => r'7d6cdd44370db8220194d80d65d85cafe0485b11';

/// See also [sectorPumpsFuture].
@ProviderFor(sectorPumpsFuture)
const sectorPumpsFutureProvider = SectorPumpsFutureFamily();

/// See also [sectorPumpsFuture].
class SectorPumpsFutureFamily extends Family<AsyncValue<List<SectorPump?>>> {
  /// See also [sectorPumpsFuture].
  const SectorPumpsFutureFamily();

  /// See also [sectorPumpsFuture].
  SectorPumpsFutureProvider call(
    String sectorId,
  ) {
    return SectorPumpsFutureProvider(
      sectorId,
    );
  }

  @override
  SectorPumpsFutureProvider getProviderOverride(
    covariant SectorPumpsFutureProvider provider,
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
  String? get name => r'sectorPumpsFutureProvider';
}

/// See also [sectorPumpsFuture].
class SectorPumpsFutureProvider
    extends AutoDisposeFutureProvider<List<SectorPump?>> {
  /// See also [sectorPumpsFuture].
  SectorPumpsFutureProvider(
    String sectorId,
  ) : this._internal(
          (ref) => sectorPumpsFuture(
            ref as SectorPumpsFutureRef,
            sectorId,
          ),
          from: sectorPumpsFutureProvider,
          name: r'sectorPumpsFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sectorPumpsFutureHash,
          dependencies: SectorPumpsFutureFamily._dependencies,
          allTransitiveDependencies:
              SectorPumpsFutureFamily._allTransitiveDependencies,
          sectorId: sectorId,
        );

  SectorPumpsFutureProvider._internal(
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
    FutureOr<List<SectorPump?>> Function(SectorPumpsFutureRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SectorPumpsFutureProvider._internal(
        (ref) => create(ref as SectorPumpsFutureRef),
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
  AutoDisposeFutureProviderElement<List<SectorPump?>> createElement() {
    return _SectorPumpsFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SectorPumpsFutureProvider && other.sectorId == sectorId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sectorId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SectorPumpsFutureRef on AutoDisposeFutureProviderRef<List<SectorPump?>> {
  /// The parameter `sectorId` of this provider.
  String get sectorId;
}

class _SectorPumpsFutureProviderElement
    extends AutoDisposeFutureProviderElement<List<SectorPump?>>
    with SectorPumpsFutureRef {
  _SectorPumpsFutureProviderElement(super.provider);

  @override
  String get sectorId => (origin as SectorPumpsFutureProvider).sectorId;
}

String _$availablePumpsFutureHash() =>
    r'43fd7805a8c94e59ca4aa909104c0d1bb718a6b6';

/// See also [availablePumpsFuture].
@ProviderFor(availablePumpsFuture)
const availablePumpsFutureProvider = AvailablePumpsFutureFamily();

/// See also [availablePumpsFuture].
class AvailablePumpsFutureFamily extends Family<AsyncValue<List<Pump>>> {
  /// See also [availablePumpsFuture].
  const AvailablePumpsFutureFamily();

  /// See also [availablePumpsFuture].
  AvailablePumpsFutureProvider call(
    String sectorId,
  ) {
    return AvailablePumpsFutureProvider(
      sectorId,
    );
  }

  @override
  AvailablePumpsFutureProvider getProviderOverride(
    covariant AvailablePumpsFutureProvider provider,
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
  String? get name => r'availablePumpsFutureProvider';
}

/// See also [availablePumpsFuture].
class AvailablePumpsFutureProvider
    extends AutoDisposeFutureProvider<List<Pump>> {
  /// See also [availablePumpsFuture].
  AvailablePumpsFutureProvider(
    String sectorId,
  ) : this._internal(
          (ref) => availablePumpsFuture(
            ref as AvailablePumpsFutureRef,
            sectorId,
          ),
          from: availablePumpsFutureProvider,
          name: r'availablePumpsFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$availablePumpsFutureHash,
          dependencies: AvailablePumpsFutureFamily._dependencies,
          allTransitiveDependencies:
              AvailablePumpsFutureFamily._allTransitiveDependencies,
          sectorId: sectorId,
        );

  AvailablePumpsFutureProvider._internal(
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
    FutureOr<List<Pump>> Function(AvailablePumpsFutureRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AvailablePumpsFutureProvider._internal(
        (ref) => create(ref as AvailablePumpsFutureRef),
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
  AutoDisposeFutureProviderElement<List<Pump>> createElement() {
    return _AvailablePumpsFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AvailablePumpsFutureProvider && other.sectorId == sectorId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sectorId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AvailablePumpsFutureRef on AutoDisposeFutureProviderRef<List<Pump>> {
  /// The parameter `sectorId` of this provider.
  String get sectorId;
}

class _AvailablePumpsFutureProviderElement
    extends AutoDisposeFutureProviderElement<List<Pump>>
    with AvailablePumpsFutureRef {
  _AvailablePumpsFutureProviderElement(super.provider);

  @override
  String get sectorId => (origin as AvailablePumpsFutureProvider).sectorId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
