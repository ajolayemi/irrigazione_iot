// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pump_details_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pumpDetailsRepositoryHash() =>
    r'eea008c190f73783cae10ee2379676a68d9c3492';

/// See also [pumpDetailsRepository].
@ProviderFor(pumpDetailsRepository)
final pumpDetailsRepositoryProvider = Provider<PumpDetailsRepository>.internal(
  pumpDetailsRepository,
  name: r'pumpDetailsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pumpDetailsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PumpDetailsRepositoryRef = ProviderRef<PumpDetailsRepository>;
String _$pumpDetailsFutureHash() => r'7a30864146ff9786bd42ec896c3fb6bd09c6bf40';

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

/// See also [pumpDetailsFuture].
@ProviderFor(pumpDetailsFuture)
const pumpDetailsFutureProvider = PumpDetailsFutureFamily();

/// See also [pumpDetailsFuture].
class PumpDetailsFutureFamily extends Family<AsyncValue<PumpDetails?>> {
  /// See also [pumpDetailsFuture].
  const PumpDetailsFutureFamily();

  /// See also [pumpDetailsFuture].
  PumpDetailsFutureProvider call(
    String pumpId,
  ) {
    return PumpDetailsFutureProvider(
      pumpId,
    );
  }

  @override
  PumpDetailsFutureProvider getProviderOverride(
    covariant PumpDetailsFutureProvider provider,
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
  String? get name => r'pumpDetailsFutureProvider';
}

/// See also [pumpDetailsFuture].
class PumpDetailsFutureProvider
    extends AutoDisposeFutureProvider<PumpDetails?> {
  /// See also [pumpDetailsFuture].
  PumpDetailsFutureProvider(
    String pumpId,
  ) : this._internal(
          (ref) => pumpDetailsFuture(
            ref as PumpDetailsFutureRef,
            pumpId,
          ),
          from: pumpDetailsFutureProvider,
          name: r'pumpDetailsFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$pumpDetailsFutureHash,
          dependencies: PumpDetailsFutureFamily._dependencies,
          allTransitiveDependencies:
              PumpDetailsFutureFamily._allTransitiveDependencies,
          pumpId: pumpId,
        );

  PumpDetailsFutureProvider._internal(
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
    FutureOr<PumpDetails?> Function(PumpDetailsFutureRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PumpDetailsFutureProvider._internal(
        (ref) => create(ref as PumpDetailsFutureRef),
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
  AutoDisposeFutureProviderElement<PumpDetails?> createElement() {
    return _PumpDetailsFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PumpDetailsFutureProvider && other.pumpId == pumpId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pumpId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PumpDetailsFutureRef on AutoDisposeFutureProviderRef<PumpDetails?> {
  /// The parameter `pumpId` of this provider.
  String get pumpId;
}

class _PumpDetailsFutureProviderElement
    extends AutoDisposeFutureProviderElement<PumpDetails?>
    with PumpDetailsFutureRef {
  _PumpDetailsFutureProviderElement(super.provider);

  @override
  String get pumpId => (origin as PumpDetailsFutureProvider).pumpId;
}

String _$pumpDetailsStreamHash() => r'030e422ab4f1864d03354dede7b30a2a3f5d6b18';

/// See also [pumpDetailsStream].
@ProviderFor(pumpDetailsStream)
const pumpDetailsStreamProvider = PumpDetailsStreamFamily();

/// See also [pumpDetailsStream].
class PumpDetailsStreamFamily extends Family<AsyncValue<PumpDetails?>> {
  /// See also [pumpDetailsStream].
  const PumpDetailsStreamFamily();

  /// See also [pumpDetailsStream].
  PumpDetailsStreamProvider call(
    String pumpId,
  ) {
    return PumpDetailsStreamProvider(
      pumpId,
    );
  }

  @override
  PumpDetailsStreamProvider getProviderOverride(
    covariant PumpDetailsStreamProvider provider,
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
  String? get name => r'pumpDetailsStreamProvider';
}

/// See also [pumpDetailsStream].
class PumpDetailsStreamProvider
    extends AutoDisposeStreamProvider<PumpDetails?> {
  /// See also [pumpDetailsStream].
  PumpDetailsStreamProvider(
    String pumpId,
  ) : this._internal(
          (ref) => pumpDetailsStream(
            ref as PumpDetailsStreamRef,
            pumpId,
          ),
          from: pumpDetailsStreamProvider,
          name: r'pumpDetailsStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$pumpDetailsStreamHash,
          dependencies: PumpDetailsStreamFamily._dependencies,
          allTransitiveDependencies:
              PumpDetailsStreamFamily._allTransitiveDependencies,
          pumpId: pumpId,
        );

  PumpDetailsStreamProvider._internal(
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
    Stream<PumpDetails?> Function(PumpDetailsStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PumpDetailsStreamProvider._internal(
        (ref) => create(ref as PumpDetailsStreamRef),
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
  AutoDisposeStreamProviderElement<PumpDetails?> createElement() {
    return _PumpDetailsStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PumpDetailsStreamProvider && other.pumpId == pumpId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pumpId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PumpDetailsStreamRef on AutoDisposeStreamProviderRef<PumpDetails?> {
  /// The parameter `pumpId` of this provider.
  String get pumpId;
}

class _PumpDetailsStreamProviderElement
    extends AutoDisposeStreamProviderElement<PumpDetails?>
    with PumpDetailsStreamRef {
  _PumpDetailsStreamProviderElement(super.provider);

  @override
  String get pumpId => (origin as PumpDetailsStreamProvider).pumpId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
