// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pump_status_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pumpStatusRepositoryHash() =>
    r'520f01e3a384a9221c677c4d04821a41a2163be6';

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
String _$pumpStatusStreamHash() => r'6730abab2fdd5e389aeb1e441c6a8ac399cf37a3';

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
class PumpStatusStreamFamily extends Family<AsyncValue<PumpStatus>> {
  /// See also [pumpStatusStream].
  const PumpStatusStreamFamily();

  /// See also [pumpStatusStream].
  PumpStatusStreamProvider call(
    String pumpId,
  ) {
    return PumpStatusStreamProvider(
      pumpId,
    );
  }

  @override
  PumpStatusStreamProvider getProviderOverride(
    covariant PumpStatusStreamProvider provider,
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
  String? get name => r'pumpStatusStreamProvider';
}

/// See also [pumpStatusStream].
class PumpStatusStreamProvider extends AutoDisposeStreamProvider<PumpStatus> {
  /// See also [pumpStatusStream].
  PumpStatusStreamProvider(
    String pumpId,
  ) : this._internal(
          (ref) => pumpStatusStream(
            ref as PumpStatusStreamRef,
            pumpId,
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
          pumpId: pumpId,
        );

  PumpStatusStreamProvider._internal(
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
    Stream<PumpStatus> Function(PumpStatusStreamRef provider) create,
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
        pumpId: pumpId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<PumpStatus> createElement() {
    return _PumpStatusStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PumpStatusStreamProvider && other.pumpId == pumpId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pumpId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PumpStatusStreamRef on AutoDisposeStreamProviderRef<PumpStatus> {
  /// The parameter `pumpId` of this provider.
  String get pumpId;
}

class _PumpStatusStreamProviderElement
    extends AutoDisposeStreamProviderElement<PumpStatus>
    with PumpStatusStreamRef {
  _PumpStatusStreamProviderElement(super.provider);

  @override
  String get pumpId => (origin as PumpStatusStreamProvider).pumpId;
}

String _$pumpStatusFutureHash() => r'eaa225cfd5081254a4a38e3580f63f71fc6e5099';

/// See also [pumpStatusFuture].
@ProviderFor(pumpStatusFuture)
const pumpStatusFutureProvider = PumpStatusFutureFamily();

/// See also [pumpStatusFuture].
class PumpStatusFutureFamily extends Family<AsyncValue<PumpStatus>> {
  /// See also [pumpStatusFuture].
  const PumpStatusFutureFamily();

  /// See also [pumpStatusFuture].
  PumpStatusFutureProvider call(
    String pumpId,
  ) {
    return PumpStatusFutureProvider(
      pumpId,
    );
  }

  @override
  PumpStatusFutureProvider getProviderOverride(
    covariant PumpStatusFutureProvider provider,
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
  String? get name => r'pumpStatusFutureProvider';
}

/// See also [pumpStatusFuture].
class PumpStatusFutureProvider extends AutoDisposeFutureProvider<PumpStatus> {
  /// See also [pumpStatusFuture].
  PumpStatusFutureProvider(
    String pumpId,
  ) : this._internal(
          (ref) => pumpStatusFuture(
            ref as PumpStatusFutureRef,
            pumpId,
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
          pumpId: pumpId,
        );

  PumpStatusFutureProvider._internal(
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
    FutureOr<PumpStatus> Function(PumpStatusFutureRef provider) create,
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
        pumpId: pumpId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<PumpStatus> createElement() {
    return _PumpStatusFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PumpStatusFutureProvider && other.pumpId == pumpId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pumpId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PumpStatusFutureRef on AutoDisposeFutureProviderRef<PumpStatus> {
  /// The parameter `pumpId` of this provider.
  String get pumpId;
}

class _PumpStatusFutureProviderElement
    extends AutoDisposeFutureProviderElement<PumpStatus>
    with PumpStatusFutureRef {
  _PumpStatusFutureProviderElement(super.provider);

  @override
  String get pumpId => (origin as PumpStatusFutureProvider).pumpId;
}

String _$pumpStatusToggleHash() => r'37464c1daddd1583eb6a29925091c975b2973bd1';

/// See also [pumpStatusToggle].
@ProviderFor(pumpStatusToggle)
const pumpStatusToggleProvider = PumpStatusToggleFamily();

/// See also [pumpStatusToggle].
class PumpStatusToggleFamily extends Family<AsyncValue<void>> {
  /// See also [pumpStatusToggle].
  const PumpStatusToggleFamily();

  /// See also [pumpStatusToggle].
  PumpStatusToggleProvider call(
    String pumpId,
    String status,
  ) {
    return PumpStatusToggleProvider(
      pumpId,
      status,
    );
  }

  @override
  PumpStatusToggleProvider getProviderOverride(
    covariant PumpStatusToggleProvider provider,
  ) {
    return call(
      provider.pumpId,
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
    String pumpId,
    String status,
  ) : this._internal(
          (ref) => pumpStatusToggle(
            ref as PumpStatusToggleRef,
            pumpId,
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
          pumpId: pumpId,
          status: status,
        );

  PumpStatusToggleProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.pumpId,
    required this.status,
  }) : super.internal();

  final String pumpId;
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
        pumpId: pumpId,
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
        other.pumpId == pumpId &&
        other.status == status;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pumpId.hashCode);
    hash = _SystemHash.combine(hash, status.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PumpStatusToggleRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `pumpId` of this provider.
  String get pumpId;

  /// The parameter `status` of this provider.
  String get status;
}

class _PumpStatusToggleProviderElement
    extends AutoDisposeFutureProviderElement<void> with PumpStatusToggleRef {
  _PumpStatusToggleProviderElement(super.provider);

  @override
  String get pumpId => (origin as PumpStatusToggleProvider).pumpId;
  @override
  String get status => (origin as PumpStatusToggleProvider).status;
}

String _$lastDispensationStreamHash() =>
    r'7916dc0d791b7024e58983e7b56b550329d7f82b';

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
    r'4e0a72b6d9627cbdfcc9e92107166b935a910f20';

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
