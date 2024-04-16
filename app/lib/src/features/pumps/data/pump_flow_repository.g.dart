// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pump_flow_repository.dart';

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
String _$pumpTotalDispensedLitresHash() =>
    r'8468f8749064bc330e192da605b97360ae008294';

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
