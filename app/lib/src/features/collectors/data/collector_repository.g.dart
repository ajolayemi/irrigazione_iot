// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collector_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$collectorRepositoryHash() =>
    r'a4ce994f4547eed1c56d6911eebe685ee54cde44';

/// See also [collectorRepository].
@ProviderFor(collectorRepository)
final collectorRepositoryProvider = Provider<CollectorRepository>.internal(
  collectorRepository,
  name: r'collectorRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$collectorRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CollectorRepositoryRef = ProviderRef<CollectorRepository>;
String _$collectorListStreamHash() =>
    r'b8168ccacd21e04f94a1d95f25f9d2fcdab541f9';

/// See also [collectorListStream].
@ProviderFor(collectorListStream)
final collectorListStreamProvider =
    AutoDisposeStreamProvider<List<Collector?>>.internal(
  collectorListStream,
  name: r'collectorListStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$collectorListStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CollectorListStreamRef = AutoDisposeStreamProviderRef<List<Collector?>>;
String _$collectorListFutureHash() =>
    r'51bfdb5832092d71554050a6e82b2eb33123d4ce';

/// See also [collectorListFuture].
@ProviderFor(collectorListFuture)
final collectorListFutureProvider =
    AutoDisposeFutureProvider<List<Collector?>>.internal(
  collectorListFuture,
  name: r'collectorListFutureProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$collectorListFutureHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CollectorListFutureRef = AutoDisposeFutureProviderRef<List<Collector?>>;
String _$usedCollectorNamesStreamHash() =>
    r'de0b3883f6cb16463a42ec4ec090bcf3826e388c';

/// See also [usedCollectorNamesStream].
@ProviderFor(usedCollectorNamesStream)
final usedCollectorNamesStreamProvider =
    AutoDisposeStreamProvider<List<String?>>.internal(
  usedCollectorNamesStream,
  name: r'usedCollectorNamesStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$usedCollectorNamesStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UsedCollectorNamesStreamRef
    = AutoDisposeStreamProviderRef<List<String?>>;
String _$collectorStreamHash() => r'dfa541795f89f997fdd13a3a4bb79d1f887f7b6a';

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

/// Watches a single instance of [Collector] as specified by [String]
///
/// Copied from [collectorStream].
@ProviderFor(collectorStream)
const collectorStreamProvider = CollectorStreamFamily();

/// Watches a single instance of [Collector] as specified by [String]
///
/// Copied from [collectorStream].
class CollectorStreamFamily extends Family<AsyncValue<Collector?>> {
  /// Watches a single instance of [Collector] as specified by [String]
  ///
  /// Copied from [collectorStream].
  const CollectorStreamFamily();

  /// Watches a single instance of [Collector] as specified by [String]
  ///
  /// Copied from [collectorStream].
  CollectorStreamProvider call(
    String collectorId,
  ) {
    return CollectorStreamProvider(
      collectorId,
    );
  }

  @override
  CollectorStreamProvider getProviderOverride(
    covariant CollectorStreamProvider provider,
  ) {
    return call(
      provider.collectorId,
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
  String? get name => r'collectorStreamProvider';
}

/// Watches a single instance of [Collector] as specified by [String]
///
/// Copied from [collectorStream].
class CollectorStreamProvider extends AutoDisposeStreamProvider<Collector?> {
  /// Watches a single instance of [Collector] as specified by [String]
  ///
  /// Copied from [collectorStream].
  CollectorStreamProvider(
    String collectorId,
  ) : this._internal(
          (ref) => collectorStream(
            ref as CollectorStreamRef,
            collectorId,
          ),
          from: collectorStreamProvider,
          name: r'collectorStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$collectorStreamHash,
          dependencies: CollectorStreamFamily._dependencies,
          allTransitiveDependencies:
              CollectorStreamFamily._allTransitiveDependencies,
          collectorId: collectorId,
        );

  CollectorStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.collectorId,
  }) : super.internal();

  final String collectorId;

  @override
  Override overrideWith(
    Stream<Collector?> Function(CollectorStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CollectorStreamProvider._internal(
        (ref) => create(ref as CollectorStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        collectorId: collectorId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Collector?> createElement() {
    return _CollectorStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CollectorStreamProvider && other.collectorId == collectorId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, collectorId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CollectorStreamRef on AutoDisposeStreamProviderRef<Collector?> {
  /// The parameter `collectorId` of this provider.
  String get collectorId;
}

class _CollectorStreamProviderElement
    extends AutoDisposeStreamProviderElement<Collector?>
    with CollectorStreamRef {
  _CollectorStreamProviderElement(super.provider);

  @override
  String get collectorId => (origin as CollectorStreamProvider).collectorId;
}

String _$collectorFutureHash() => r'be315e81e6328d42925e6b3438438a1d40db2405';

/// Gets a single instance of [Collector] as specified by [String]
///
/// Copied from [collectorFuture].
@ProviderFor(collectorFuture)
const collectorFutureProvider = CollectorFutureFamily();

/// Gets a single instance of [Collector] as specified by [String]
///
/// Copied from [collectorFuture].
class CollectorFutureFamily extends Family<AsyncValue<Collector?>> {
  /// Gets a single instance of [Collector] as specified by [String]
  ///
  /// Copied from [collectorFuture].
  const CollectorFutureFamily();

  /// Gets a single instance of [Collector] as specified by [String]
  ///
  /// Copied from [collectorFuture].
  CollectorFutureProvider call(
    String collectorId,
  ) {
    return CollectorFutureProvider(
      collectorId,
    );
  }

  @override
  CollectorFutureProvider getProviderOverride(
    covariant CollectorFutureProvider provider,
  ) {
    return call(
      provider.collectorId,
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
  String? get name => r'collectorFutureProvider';
}

/// Gets a single instance of [Collector] as specified by [String]
///
/// Copied from [collectorFuture].
class CollectorFutureProvider extends AutoDisposeFutureProvider<Collector?> {
  /// Gets a single instance of [Collector] as specified by [String]
  ///
  /// Copied from [collectorFuture].
  CollectorFutureProvider(
    String collectorId,
  ) : this._internal(
          (ref) => collectorFuture(
            ref as CollectorFutureRef,
            collectorId,
          ),
          from: collectorFutureProvider,
          name: r'collectorFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$collectorFutureHash,
          dependencies: CollectorFutureFamily._dependencies,
          allTransitiveDependencies:
              CollectorFutureFamily._allTransitiveDependencies,
          collectorId: collectorId,
        );

  CollectorFutureProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.collectorId,
  }) : super.internal();

  final String collectorId;

  @override
  Override overrideWith(
    FutureOr<Collector?> Function(CollectorFutureRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CollectorFutureProvider._internal(
        (ref) => create(ref as CollectorFutureRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        collectorId: collectorId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Collector?> createElement() {
    return _CollectorFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CollectorFutureProvider && other.collectorId == collectorId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, collectorId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CollectorFutureRef on AutoDisposeFutureProviderRef<Collector?> {
  /// The parameter `collectorId` of this provider.
  String get collectorId;
}

class _CollectorFutureProviderElement
    extends AutoDisposeFutureProviderElement<Collector?>
    with CollectorFutureRef {
  _CollectorFutureProviderElement(super.provider);

  @override
  String get collectorId => (origin as CollectorFutureProvider).collectorId;
}

String _$collectorBatteryLevelStreamHash() =>
    r'63b6561c6633dfffc18d965f31134f051236d57a';

/// See also [collectorBatteryLevelStream].
@ProviderFor(collectorBatteryLevelStream)
const collectorBatteryLevelStreamProvider = CollectorBatteryLevelStreamFamily();

/// See also [collectorBatteryLevelStream].
class CollectorBatteryLevelStreamFamily extends Family<AsyncValue<double?>> {
  /// See also [collectorBatteryLevelStream].
  const CollectorBatteryLevelStreamFamily();

  /// See also [collectorBatteryLevelStream].
  CollectorBatteryLevelStreamProvider call({
    required String collectorId,
  }) {
    return CollectorBatteryLevelStreamProvider(
      collectorId: collectorId,
    );
  }

  @override
  CollectorBatteryLevelStreamProvider getProviderOverride(
    covariant CollectorBatteryLevelStreamProvider provider,
  ) {
    return call(
      collectorId: provider.collectorId,
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
  String? get name => r'collectorBatteryLevelStreamProvider';
}

/// See also [collectorBatteryLevelStream].
class CollectorBatteryLevelStreamProvider
    extends AutoDisposeStreamProvider<double?> {
  /// See also [collectorBatteryLevelStream].
  CollectorBatteryLevelStreamProvider({
    required String collectorId,
  }) : this._internal(
          (ref) => collectorBatteryLevelStream(
            ref as CollectorBatteryLevelStreamRef,
            collectorId: collectorId,
          ),
          from: collectorBatteryLevelStreamProvider,
          name: r'collectorBatteryLevelStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$collectorBatteryLevelStreamHash,
          dependencies: CollectorBatteryLevelStreamFamily._dependencies,
          allTransitiveDependencies:
              CollectorBatteryLevelStreamFamily._allTransitiveDependencies,
          collectorId: collectorId,
        );

  CollectorBatteryLevelStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.collectorId,
  }) : super.internal();

  final String collectorId;

  @override
  Override overrideWith(
    Stream<double?> Function(CollectorBatteryLevelStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CollectorBatteryLevelStreamProvider._internal(
        (ref) => create(ref as CollectorBatteryLevelStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        collectorId: collectorId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<double?> createElement() {
    return _CollectorBatteryLevelStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CollectorBatteryLevelStreamProvider &&
        other.collectorId == collectorId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, collectorId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CollectorBatteryLevelStreamRef on AutoDisposeStreamProviderRef<double?> {
  /// The parameter `collectorId` of this provider.
  String get collectorId;
}

class _CollectorBatteryLevelStreamProviderElement
    extends AutoDisposeStreamProviderElement<double?>
    with CollectorBatteryLevelStreamRef {
  _CollectorBatteryLevelStreamProviderElement(super.provider);

  @override
  String get collectorId =>
      (origin as CollectorBatteryLevelStreamProvider).collectorId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
