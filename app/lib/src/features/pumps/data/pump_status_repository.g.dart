// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pump_status_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pumpStatusRepositoryHash() =>
    r'f844aefee34c2e5129d0dae91ae404d23709276e';

/// See also [pumpStatusRepository].
@ProviderFor(pumpStatusRepository)
final pumpStatusRepositoryProvider = Provider<PumpStatusRepository>.internal(
  pumpStatusRepository,
  name: r'pumpStatusRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pumpStatusRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PumpStatusRepositoryRef = ProviderRef<PumpStatusRepository>;
String _$pumpStatusStreamHash() => r'346b60c12ed006d25f3b851baa2fea275abc9355';

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

/// See also [pumpStatusStream].
@ProviderFor(pumpStatusStream)
const pumpStatusStreamProvider = PumpStatusStreamFamily();

/// See also [pumpStatusStream].
class PumpStatusStreamFamily extends Family<AsyncValue<bool?>> {
  /// See also [pumpStatusStream].
  const PumpStatusStreamFamily();

  /// See also [pumpStatusStream].
  PumpStatusStreamProvider call(
    Pump pump,
  ) {
    return PumpStatusStreamProvider(
      pump,
    );
  }

  @override
  PumpStatusStreamProvider getProviderOverride(
    covariant PumpStatusStreamProvider provider,
  ) {
    return call(
      provider.pump,
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
  String? get name => r'pumpStatusStreamProvider';
}

/// See also [pumpStatusStream].
class PumpStatusStreamProvider extends AutoDisposeStreamProvider<bool?> {
  /// See also [pumpStatusStream].
  PumpStatusStreamProvider(
    Pump pump,
  ) : this._internal(
          (ref) => pumpStatusStream(
            ref as PumpStatusStreamRef,
            pump,
          ),
          from: pumpStatusStreamProvider,
          name: r'pumpStatusStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$pumpStatusStreamHash,
          dependencies: PumpStatusStreamFamily._dependencies,
          allTransitiveDependencies:
              PumpStatusStreamFamily._allTransitiveDependencies,
          pump: pump,
        );

  PumpStatusStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.pump,
  }) : super.internal();

  final Pump pump;

  @override
  Override overrideWith(
    Stream<bool?> Function(PumpStatusStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PumpStatusStreamProvider._internal(
        (ref) => create(ref as PumpStatusStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        pump: pump,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<bool?> createElement() {
    return _PumpStatusStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PumpStatusStreamProvider && other.pump == pump;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pump.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PumpStatusStreamRef on AutoDisposeStreamProviderRef<bool?> {
  /// The parameter `pump` of this provider.
  Pump get pump;
}

class _PumpStatusStreamProviderElement
    extends AutoDisposeStreamProviderElement<bool?> with PumpStatusStreamRef {
  _PumpStatusStreamProviderElement(super.provider);

  @override
  Pump get pump => (origin as PumpStatusStreamProvider).pump;
}

String _$pumpStatusFutureHash() => r'1e30f8f70a6710efb4861b694eba259ede6b052b';

/// See also [pumpStatusFuture].
@ProviderFor(pumpStatusFuture)
const pumpStatusFutureProvider = PumpStatusFutureFamily();

/// See also [pumpStatusFuture].
class PumpStatusFutureFamily extends Family<AsyncValue<bool?>> {
  /// See also [pumpStatusFuture].
  const PumpStatusFutureFamily();

  /// See also [pumpStatusFuture].
  PumpStatusFutureProvider call(
    Pump pump,
  ) {
    return PumpStatusFutureProvider(
      pump,
    );
  }

  @override
  PumpStatusFutureProvider getProviderOverride(
    covariant PumpStatusFutureProvider provider,
  ) {
    return call(
      provider.pump,
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
  String? get name => r'pumpStatusFutureProvider';
}

/// See also [pumpStatusFuture].
class PumpStatusFutureProvider extends AutoDisposeFutureProvider<bool?> {
  /// See also [pumpStatusFuture].
  PumpStatusFutureProvider(
    Pump pump,
  ) : this._internal(
          (ref) => pumpStatusFuture(
            ref as PumpStatusFutureRef,
            pump,
          ),
          from: pumpStatusFutureProvider,
          name: r'pumpStatusFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$pumpStatusFutureHash,
          dependencies: PumpStatusFutureFamily._dependencies,
          allTransitiveDependencies:
              PumpStatusFutureFamily._allTransitiveDependencies,
          pump: pump,
        );

  PumpStatusFutureProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.pump,
  }) : super.internal();

  final Pump pump;

  @override
  Override overrideWith(
    FutureOr<bool?> Function(PumpStatusFutureRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PumpStatusFutureProvider._internal(
        (ref) => create(ref as PumpStatusFutureRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        pump: pump,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool?> createElement() {
    return _PumpStatusFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PumpStatusFutureProvider && other.pump == pump;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pump.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PumpStatusFutureRef on AutoDisposeFutureProviderRef<bool?> {
  /// The parameter `pump` of this provider.
  Pump get pump;
}

class _PumpStatusFutureProviderElement
    extends AutoDisposeFutureProviderElement<bool?> with PumpStatusFutureRef {
  _PumpStatusFutureProviderElement(super.provider);

  @override
  Pump get pump => (origin as PumpStatusFutureProvider).pump;
}

String _$pumpStatusToggleHash() => r'49c941db5c176170a96eb090e4a6cb3b759655df';

/// See also [pumpStatusToggle].
@ProviderFor(pumpStatusToggle)
const pumpStatusToggleProvider = PumpStatusToggleFamily();

/// See also [pumpStatusToggle].
class PumpStatusToggleFamily extends Family<AsyncValue<void>> {
  /// See also [pumpStatusToggle].
  const PumpStatusToggleFamily();

  /// See also [pumpStatusToggle].
  PumpStatusToggleProvider call(
    Pump pump,
    String status,
  ) {
    return PumpStatusToggleProvider(
      pump,
      status,
    );
  }

  @override
  PumpStatusToggleProvider getProviderOverride(
    covariant PumpStatusToggleProvider provider,
  ) {
    return call(
      provider.pump,
      provider.status,
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
  String? get name => r'pumpStatusToggleProvider';
}

/// See also [pumpStatusToggle].
class PumpStatusToggleProvider extends AutoDisposeFutureProvider<void> {
  /// See also [pumpStatusToggle].
  PumpStatusToggleProvider(
    Pump pump,
    String status,
  ) : this._internal(
          (ref) => pumpStatusToggle(
            ref as PumpStatusToggleRef,
            pump,
            status,
          ),
          from: pumpStatusToggleProvider,
          name: r'pumpStatusToggleProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$pumpStatusToggleHash,
          dependencies: PumpStatusToggleFamily._dependencies,
          allTransitiveDependencies:
              PumpStatusToggleFamily._allTransitiveDependencies,
          pump: pump,
          status: status,
        );

  PumpStatusToggleProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.pump,
    required this.status,
  }) : super.internal();

  final Pump pump;
  final String status;

  @override
  Override overrideWith(
    FutureOr<void> Function(PumpStatusToggleRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PumpStatusToggleProvider._internal(
        (ref) => create(ref as PumpStatusToggleRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        pump: pump,
        status: status,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _PumpStatusToggleProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PumpStatusToggleProvider &&
        other.pump == pump &&
        other.status == status;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pump.hashCode);
    hash = _SystemHash.combine(hash, status.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PumpStatusToggleRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `pump` of this provider.
  Pump get pump;

  /// The parameter `status` of this provider.
  String get status;
}

class _PumpStatusToggleProviderElement
    extends AutoDisposeFutureProviderElement<void> with PumpStatusToggleRef {
  _PumpStatusToggleProviderElement(super.provider);

  @override
  Pump get pump => (origin as PumpStatusToggleProvider).pump;
  @override
  String get status => (origin as PumpStatusToggleProvider).status;
}

String _$lastDispensationStreamHash() =>
    r'3d726b4f5c6d8b57f62ac872e6ef356e0ae1ca45';

/// See also [lastDispensationStream].
@ProviderFor(lastDispensationStream)
const lastDispensationStreamProvider = LastDispensationStreamFamily();

/// See also [lastDispensationStream].
class LastDispensationStreamFamily extends Family<AsyncValue<DateTime?>> {
  /// See also [lastDispensationStream].
  const LastDispensationStreamFamily();

  /// See also [lastDispensationStream].
  LastDispensationStreamProvider call(
    String pumpId,
  ) {
    return LastDispensationStreamProvider(
      pumpId,
    );
  }

  @override
  LastDispensationStreamProvider getProviderOverride(
    covariant LastDispensationStreamProvider provider,
  ) {
    return call(
      provider.pumpId,
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
  String? get name => r'lastDispensationStreamProvider';
}

/// See also [lastDispensationStream].
class LastDispensationStreamProvider
    extends AutoDisposeStreamProvider<DateTime?> {
  /// See also [lastDispensationStream].
  LastDispensationStreamProvider(
    String pumpId,
  ) : this._internal(
          (ref) => lastDispensationStream(
            ref as LastDispensationStreamRef,
            pumpId,
          ),
          from: lastDispensationStreamProvider,
          name: r'lastDispensationStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$lastDispensationStreamHash,
          dependencies: LastDispensationStreamFamily._dependencies,
          allTransitiveDependencies:
              LastDispensationStreamFamily._allTransitiveDependencies,
          pumpId: pumpId,
        );

  LastDispensationStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.pumpId,
  }) : super.internal();

  final String pumpId;

  @override
  Override overrideWith(
    Stream<DateTime?> Function(LastDispensationStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LastDispensationStreamProvider._internal(
        (ref) => create(ref as LastDispensationStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        pumpId: pumpId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<DateTime?> createElement() {
    return _LastDispensationStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LastDispensationStreamProvider && other.pumpId == pumpId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pumpId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin LastDispensationStreamRef on AutoDisposeStreamProviderRef<DateTime?> {
  /// The parameter `pumpId` of this provider.
  String get pumpId;
}

class _LastDispensationStreamProviderElement
    extends AutoDisposeStreamProviderElement<DateTime?>
    with LastDispensationStreamRef {
  _LastDispensationStreamProviderElement(super.provider);

  @override
  String get pumpId => (origin as LastDispensationStreamProvider).pumpId;
}

String _$lastDispensationFutureHash() =>
    r'a118b2f820578c3cf14b47e90469f1129cfd3a88';

/// See also [lastDispensationFuture].
@ProviderFor(lastDispensationFuture)
const lastDispensationFutureProvider = LastDispensationFutureFamily();

/// See also [lastDispensationFuture].
class LastDispensationFutureFamily extends Family<AsyncValue<DateTime?>> {
  /// See also [lastDispensationFuture].
  const LastDispensationFutureFamily();

  /// See also [lastDispensationFuture].
  LastDispensationFutureProvider call(
    String pumpId,
  ) {
    return LastDispensationFutureProvider(
      pumpId,
    );
  }

  @override
  LastDispensationFutureProvider getProviderOverride(
    covariant LastDispensationFutureProvider provider,
  ) {
    return call(
      provider.pumpId,
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
  String? get name => r'lastDispensationFutureProvider';
}

/// See also [lastDispensationFuture].
class LastDispensationFutureProvider
    extends AutoDisposeFutureProvider<DateTime?> {
  /// See also [lastDispensationFuture].
  LastDispensationFutureProvider(
    String pumpId,
  ) : this._internal(
          (ref) => lastDispensationFuture(
            ref as LastDispensationFutureRef,
            pumpId,
          ),
          from: lastDispensationFutureProvider,
          name: r'lastDispensationFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$lastDispensationFutureHash,
          dependencies: LastDispensationFutureFamily._dependencies,
          allTransitiveDependencies:
              LastDispensationFutureFamily._allTransitiveDependencies,
          pumpId: pumpId,
        );

  LastDispensationFutureProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.pumpId,
  }) : super.internal();

  final String pumpId;

  @override
  Override overrideWith(
    FutureOr<DateTime?> Function(LastDispensationFutureRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LastDispensationFutureProvider._internal(
        (ref) => create(ref as LastDispensationFutureRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        pumpId: pumpId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<DateTime?> createElement() {
    return _LastDispensationFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LastDispensationFutureProvider && other.pumpId == pumpId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pumpId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin LastDispensationFutureRef on AutoDisposeFutureProviderRef<DateTime?> {
  /// The parameter `pumpId` of this provider.
  String get pumpId;
}

class _LastDispensationFutureProviderElement
    extends AutoDisposeFutureProviderElement<DateTime?>
    with LastDispensationFutureRef {
  _LastDispensationFutureProviderElement(super.provider);

  @override
  String get pumpId => (origin as LastDispensationFutureProvider).pumpId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
