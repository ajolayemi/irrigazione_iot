// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pump_flow_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pumpFlowRepositoryHash() =>
    r'fb5cb1b35eae4faf7876b9e8c0dc8cd3de1f6c55';

/// See also [pumpFlowRepository].
@ProviderFor(pumpFlowRepository)
final pumpFlowRepositoryProvider = Provider<PumpFlowRepository>.internal(
  pumpFlowRepository,
  name: r'pumpFlowRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pumpFlowRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PumpFlowRepositoryRef = ProviderRef<PumpFlowRepository>;
String _$pumpTotalDispensedLitresHash() =>
    r'3be126b953bec9091136df38a149dcbfa3022ef2';

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

/// See also [pumpTotalDispensedLitres].
@ProviderFor(pumpTotalDispensedLitres)
const pumpTotalDispensedLitresProvider = PumpTotalDispensedLitresFamily();

/// See also [pumpTotalDispensedLitres].
class PumpTotalDispensedLitresFamily extends Family<AsyncValue<int>> {
  /// See also [pumpTotalDispensedLitres].
  const PumpTotalDispensedLitresFamily();

  /// See also [pumpTotalDispensedLitres].
  PumpTotalDispensedLitresProvider call(
    String pumpId,
  ) {
    return PumpTotalDispensedLitresProvider(
      pumpId,
    );
  }

  @override
  PumpTotalDispensedLitresProvider getProviderOverride(
    covariant PumpTotalDispensedLitresProvider provider,
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
  String? get name => r'pumpTotalDispensedLitresProvider';
}

/// See also [pumpTotalDispensedLitres].
class PumpTotalDispensedLitresProvider extends AutoDisposeStreamProvider<int> {
  /// See also [pumpTotalDispensedLitres].
  PumpTotalDispensedLitresProvider(
    String pumpId,
  ) : this._internal(
          (ref) => pumpTotalDispensedLitres(
            ref as PumpTotalDispensedLitresRef,
            pumpId,
          ),
          from: pumpTotalDispensedLitresProvider,
          name: r'pumpTotalDispensedLitresProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$pumpTotalDispensedLitresHash,
          dependencies: PumpTotalDispensedLitresFamily._dependencies,
          allTransitiveDependencies:
              PumpTotalDispensedLitresFamily._allTransitiveDependencies,
          pumpId: pumpId,
        );

  PumpTotalDispensedLitresProvider._internal(
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
    Stream<int> Function(PumpTotalDispensedLitresRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PumpTotalDispensedLitresProvider._internal(
        (ref) => create(ref as PumpTotalDispensedLitresRef),
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
  AutoDisposeStreamProviderElement<int> createElement() {
    return _PumpTotalDispensedLitresProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PumpTotalDispensedLitresProvider && other.pumpId == pumpId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pumpId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PumpTotalDispensedLitresRef on AutoDisposeStreamProviderRef<int> {
  /// The parameter `pumpId` of this provider.
  String get pumpId;
}

class _PumpTotalDispensedLitresProviderElement
    extends AutoDisposeStreamProviderElement<int>
    with PumpTotalDispensedLitresRef {
  _PumpTotalDispensedLitresProviderElement(super.provider);

  @override
  String get pumpId => (origin as PumpTotalDispensedLitresProvider).pumpId;
}

String _$lastDispensationStreamHash() =>
    r'c0f3e98ccf0dafb6d4683986b0d4e9281f5e71af';

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
