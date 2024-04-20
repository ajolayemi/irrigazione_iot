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
String _$sectorPumpStreamHash() => r'beee4e032bb8beaf0c33d2f80a9a84f73955a097';

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

/// See also [sectorPumpStream].
@ProviderFor(sectorPumpStream)
const sectorPumpStreamProvider = SectorPumpStreamFamily();

/// See also [sectorPumpStream].
class SectorPumpStreamFamily extends Family<AsyncValue<SectorPump?>> {
  /// See also [sectorPumpStream].
  const SectorPumpStreamFamily();

  /// See also [sectorPumpStream].
  SectorPumpStreamProvider call(
    String sectorId,
  ) {
    return SectorPumpStreamProvider(
      sectorId,
    );
  }

  @override
  SectorPumpStreamProvider getProviderOverride(
    covariant SectorPumpStreamProvider provider,
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
  String? get name => r'sectorPumpStreamProvider';
}

/// See also [sectorPumpStream].
class SectorPumpStreamProvider extends AutoDisposeStreamProvider<SectorPump?> {
  /// See also [sectorPumpStream].
  SectorPumpStreamProvider(
    String sectorId,
  ) : this._internal(
          (ref) => sectorPumpStream(
            ref as SectorPumpStreamRef,
            sectorId,
          ),
          from: sectorPumpStreamProvider,
          name: r'sectorPumpStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sectorPumpStreamHash,
          dependencies: SectorPumpStreamFamily._dependencies,
          allTransitiveDependencies:
              SectorPumpStreamFamily._allTransitiveDependencies,
          sectorId: sectorId,
        );

  SectorPumpStreamProvider._internal(
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
    Stream<SectorPump?> Function(SectorPumpStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SectorPumpStreamProvider._internal(
        (ref) => create(ref as SectorPumpStreamRef),
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
  AutoDisposeStreamProviderElement<SectorPump?> createElement() {
    return _SectorPumpStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SectorPumpStreamProvider && other.sectorId == sectorId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sectorId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SectorPumpStreamRef on AutoDisposeStreamProviderRef<SectorPump?> {
  /// The parameter `sectorId` of this provider.
  String get sectorId;
}

class _SectorPumpStreamProviderElement
    extends AutoDisposeStreamProviderElement<SectorPump?>
    with SectorPumpStreamRef {
  _SectorPumpStreamProviderElement(super.provider);

  @override
  String get sectorId => (origin as SectorPumpStreamProvider).sectorId;
}

String _$sectorPumpFutureHash() => r'f516e19248eb5e380591d346b1c4987b2c37acf3';

/// See also [sectorPumpFuture].
@ProviderFor(sectorPumpFuture)
const sectorPumpFutureProvider = SectorPumpFutureFamily();

/// See also [sectorPumpFuture].
class SectorPumpFutureFamily extends Family<AsyncValue<SectorPump?>> {
  /// See also [sectorPumpFuture].
  const SectorPumpFutureFamily();

  /// See also [sectorPumpFuture].
  SectorPumpFutureProvider call(
    String sectorId,
  ) {
    return SectorPumpFutureProvider(
      sectorId,
    );
  }

  @override
  SectorPumpFutureProvider getProviderOverride(
    covariant SectorPumpFutureProvider provider,
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
  String? get name => r'sectorPumpFutureProvider';
}

/// See also [sectorPumpFuture].
class SectorPumpFutureProvider extends AutoDisposeFutureProvider<SectorPump?> {
  /// See also [sectorPumpFuture].
  SectorPumpFutureProvider(
    String sectorId,
  ) : this._internal(
          (ref) => sectorPumpFuture(
            ref as SectorPumpFutureRef,
            sectorId,
          ),
          from: sectorPumpFutureProvider,
          name: r'sectorPumpFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sectorPumpFutureHash,
          dependencies: SectorPumpFutureFamily._dependencies,
          allTransitiveDependencies:
              SectorPumpFutureFamily._allTransitiveDependencies,
          sectorId: sectorId,
        );

  SectorPumpFutureProvider._internal(
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
    FutureOr<SectorPump?> Function(SectorPumpFutureRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SectorPumpFutureProvider._internal(
        (ref) => create(ref as SectorPumpFutureRef),
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
  AutoDisposeFutureProviderElement<SectorPump?> createElement() {
    return _SectorPumpFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SectorPumpFutureProvider && other.sectorId == sectorId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sectorId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SectorPumpFutureRef on AutoDisposeFutureProviderRef<SectorPump?> {
  /// The parameter `sectorId` of this provider.
  String get sectorId;
}

class _SectorPumpFutureProviderElement
    extends AutoDisposeFutureProviderElement<SectorPump?>
    with SectorPumpFutureRef {
  _SectorPumpFutureProviderElement(super.provider);

  @override
  String get sectorId => (origin as SectorPumpFutureProvider).sectorId;
}

String _$availablePumpsFutureHash() =>
    r'fdee775516f9a306e09f046d30bf4245115f88af';

/// See also [availablePumpsFuture].
@ProviderFor(availablePumpsFuture)
const availablePumpsFutureProvider = AvailablePumpsFutureFamily();

/// See also [availablePumpsFuture].
class AvailablePumpsFutureFamily extends Family<AsyncValue<List<Pump>?>> {
  /// See also [availablePumpsFuture].
  const AvailablePumpsFutureFamily();

  /// See also [availablePumpsFuture].
  AvailablePumpsFutureProvider call({
    String? alreadyConnectedPumpId,
  }) {
    return AvailablePumpsFutureProvider(
      alreadyConnectedPumpId: alreadyConnectedPumpId,
    );
  }

  @override
  AvailablePumpsFutureProvider getProviderOverride(
    covariant AvailablePumpsFutureProvider provider,
  ) {
    return call(
      alreadyConnectedPumpId: provider.alreadyConnectedPumpId,
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
    extends AutoDisposeFutureProvider<List<Pump>?> {
  /// See also [availablePumpsFuture].
  AvailablePumpsFutureProvider({
    String? alreadyConnectedPumpId,
  }) : this._internal(
          (ref) => availablePumpsFuture(
            ref as AvailablePumpsFutureRef,
            alreadyConnectedPumpId: alreadyConnectedPumpId,
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
          alreadyConnectedPumpId: alreadyConnectedPumpId,
        );

  AvailablePumpsFutureProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.alreadyConnectedPumpId,
  }) : super.internal();

  final String? alreadyConnectedPumpId;

  @override
  Override overrideWith(
    FutureOr<List<Pump>?> Function(AvailablePumpsFutureRef provider) create,
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
        alreadyConnectedPumpId: alreadyConnectedPumpId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Pump>?> createElement() {
    return _AvailablePumpsFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AvailablePumpsFutureProvider &&
        other.alreadyConnectedPumpId == alreadyConnectedPumpId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, alreadyConnectedPumpId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AvailablePumpsFutureRef on AutoDisposeFutureProviderRef<List<Pump>?> {
  /// The parameter `alreadyConnectedPumpId` of this provider.
  String? get alreadyConnectedPumpId;
}

class _AvailablePumpsFutureProviderElement
    extends AutoDisposeFutureProviderElement<List<Pump>?>
    with AvailablePumpsFutureRef {
  _AvailablePumpsFutureProviderElement(super.provider);

  @override
  String? get alreadyConnectedPumpId =>
      (origin as AvailablePumpsFutureProvider).alreadyConnectedPumpId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
