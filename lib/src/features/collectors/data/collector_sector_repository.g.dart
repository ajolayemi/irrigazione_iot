// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collector_sector_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$collectorSectorRepositoryHash() =>
    r'4e715140290b1e0f187c911117d5836ad9c1a7a1';

/// See also [collectorSectorRepository].
@ProviderFor(collectorSectorRepository)
final collectorSectorRepositoryProvider =
    Provider<CollectorSectorRepository>.internal(
  collectorSectorRepository,
  name: r'collectorSectorRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$collectorSectorRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CollectorSectorRepositoryRef = ProviderRef<CollectorSectorRepository>;
String _$collectorSectorsStreamHash() =>
    r'ab615643783ec109cef170feb54a93e68739f5ac';

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

/// See also [collectorSectorsStream].
@ProviderFor(collectorSectorsStream)
const collectorSectorsStreamProvider = CollectorSectorsStreamFamily();

/// See also [collectorSectorsStream].
class CollectorSectorsStreamFamily
    extends Family<AsyncValue<List<CollectorSector?>>> {
  /// See also [collectorSectorsStream].
  const CollectorSectorsStreamFamily();

  /// See also [collectorSectorsStream].
  CollectorSectorsStreamProvider call(
    String collectorId,
  ) {
    return CollectorSectorsStreamProvider(
      collectorId,
    );
  }

  @override
  CollectorSectorsStreamProvider getProviderOverride(
    covariant CollectorSectorsStreamProvider provider,
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
  String? get name => r'collectorSectorsStreamProvider';
}

/// See also [collectorSectorsStream].
class CollectorSectorsStreamProvider
    extends AutoDisposeStreamProvider<List<CollectorSector?>> {
  /// See also [collectorSectorsStream].
  CollectorSectorsStreamProvider(
    String collectorId,
  ) : this._internal(
          (ref) => collectorSectorsStream(
            ref as CollectorSectorsStreamRef,
            collectorId,
          ),
          from: collectorSectorsStreamProvider,
          name: r'collectorSectorsStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$collectorSectorsStreamHash,
          dependencies: CollectorSectorsStreamFamily._dependencies,
          allTransitiveDependencies:
              CollectorSectorsStreamFamily._allTransitiveDependencies,
          collectorId: collectorId,
        );

  CollectorSectorsStreamProvider._internal(
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
    Stream<List<CollectorSector?>> Function(CollectorSectorsStreamRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CollectorSectorsStreamProvider._internal(
        (ref) => create(ref as CollectorSectorsStreamRef),
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
  AutoDisposeStreamProviderElement<List<CollectorSector?>> createElement() {
    return _CollectorSectorsStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CollectorSectorsStreamProvider &&
        other.collectorId == collectorId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, collectorId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CollectorSectorsStreamRef
    on AutoDisposeStreamProviderRef<List<CollectorSector?>> {
  /// The parameter `collectorId` of this provider.
  String get collectorId;
}

class _CollectorSectorsStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<CollectorSector?>>
    with CollectorSectorsStreamRef {
  _CollectorSectorsStreamProviderElement(super.provider);

  @override
  String get collectorId =>
      (origin as CollectorSectorsStreamProvider).collectorId;
}

String _$collectorSectorsFutureHash() =>
    r'7f799b041538d6f09f680c1c3afd1388201876b6';

/// See also [collectorSectorsFuture].
@ProviderFor(collectorSectorsFuture)
const collectorSectorsFutureProvider = CollectorSectorsFutureFamily();

/// See also [collectorSectorsFuture].
class CollectorSectorsFutureFamily
    extends Family<AsyncValue<List<CollectorSector?>>> {
  /// See also [collectorSectorsFuture].
  const CollectorSectorsFutureFamily();

  /// See also [collectorSectorsFuture].
  CollectorSectorsFutureProvider call(
    String collectorId,
  ) {
    return CollectorSectorsFutureProvider(
      collectorId,
    );
  }

  @override
  CollectorSectorsFutureProvider getProviderOverride(
    covariant CollectorSectorsFutureProvider provider,
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
  String? get name => r'collectorSectorsFutureProvider';
}

/// See also [collectorSectorsFuture].
class CollectorSectorsFutureProvider
    extends AutoDisposeFutureProvider<List<CollectorSector?>> {
  /// See also [collectorSectorsFuture].
  CollectorSectorsFutureProvider(
    String collectorId,
  ) : this._internal(
          (ref) => collectorSectorsFuture(
            ref as CollectorSectorsFutureRef,
            collectorId,
          ),
          from: collectorSectorsFutureProvider,
          name: r'collectorSectorsFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$collectorSectorsFutureHash,
          dependencies: CollectorSectorsFutureFamily._dependencies,
          allTransitiveDependencies:
              CollectorSectorsFutureFamily._allTransitiveDependencies,
          collectorId: collectorId,
        );

  CollectorSectorsFutureProvider._internal(
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
    FutureOr<List<CollectorSector?>> Function(
            CollectorSectorsFutureRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CollectorSectorsFutureProvider._internal(
        (ref) => create(ref as CollectorSectorsFutureRef),
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
  AutoDisposeFutureProviderElement<List<CollectorSector?>> createElement() {
    return _CollectorSectorsFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CollectorSectorsFutureProvider &&
        other.collectorId == collectorId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, collectorId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CollectorSectorsFutureRef
    on AutoDisposeFutureProviderRef<List<CollectorSector?>> {
  /// The parameter `collectorId` of this provider.
  String get collectorId;
}

class _CollectorSectorsFutureProviderElement
    extends AutoDisposeFutureProviderElement<List<CollectorSector?>>
    with CollectorSectorsFutureRef {
  _CollectorSectorsFutureProviderElement(super.provider);

  @override
  String get collectorId =>
      (origin as CollectorSectorsFutureProvider).collectorId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
