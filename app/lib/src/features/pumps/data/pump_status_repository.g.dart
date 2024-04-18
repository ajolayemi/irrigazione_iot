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

/// Emits the status of the pump with the provided [pumpId]
///
/// Copied from [pumpStatusStream].
@ProviderFor(pumpStatusStream)
const pumpStatusStreamProvider = PumpStatusStreamFamily();

/// Emits the status of the pump with the provided [pumpId]
///
/// Copied from [pumpStatusStream].
class PumpStatusStreamFamily extends Family<AsyncValue<bool?>> {
  /// Emits the status of the pump with the provided [pumpId]
  ///
  /// Copied from [pumpStatusStream].
  const PumpStatusStreamFamily();

  /// Emits the status of the pump with the provided [pumpId]
  ///
  /// Copied from [pumpStatusStream].
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

/// Emits the status of the pump with the provided [pumpId]
///
/// Copied from [pumpStatusStream].
class PumpStatusStreamProvider extends AutoDisposeStreamProvider<bool?> {
  /// Emits the status of the pump with the provided [pumpId]
  ///
  /// Copied from [pumpStatusStream].
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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
