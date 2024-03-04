// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pump_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pumpRepositoryHash() => r'deb88bf39190b9957baae097097f7ad5f62ef4f2';

/// See also [pumpRepository].
@ProviderFor(pumpRepository)
final pumpRepositoryProvider = Provider<PumpRepository>.internal(
  pumpRepository,
  name: r'pumpRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pumpRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PumpRepositoryRef = ProviderRef<PumpRepository>;
String _$companyPumpsStreamHash() =>
    r'f13a14444cfa7d67183b6767bee8cea2adb937b8';

/// See also [companyPumpsStream].
@ProviderFor(companyPumpsStream)
final companyPumpsStreamProvider =
    AutoDisposeStreamProvider<List<Pump>>.internal(
  companyPumpsStream,
  name: r'companyPumpsStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$companyPumpsStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CompanyPumpsStreamRef = AutoDisposeStreamProviderRef<List<Pump>>;
String _$companyPumpsFutureHash() =>
    r'0ac3a9f7d22a3ef8cf03a1925c192f73692fc043';

/// See also [companyPumpsFuture].
@ProviderFor(companyPumpsFuture)
final companyPumpsFutureProvider =
    AutoDisposeFutureProvider<List<Pump>>.internal(
  companyPumpsFuture,
  name: r'companyPumpsFutureProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$companyPumpsFutureHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CompanyPumpsFutureRef = AutoDisposeFutureProviderRef<List<Pump>>;
String _$pumpStreamHash() => r'36aaea2559de858f6c04a1ae3536212e2fe63889';

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

/// See also [pumpStream].
@ProviderFor(pumpStream)
const pumpStreamProvider = PumpStreamFamily();

/// See also [pumpStream].
class PumpStreamFamily extends Family<AsyncValue<Pump?>> {
  /// See also [pumpStream].
  const PumpStreamFamily();

  /// See also [pumpStream].
  PumpStreamProvider call(
    String pumpId,
  ) {
    return PumpStreamProvider(
      pumpId,
    );
  }

  @override
  PumpStreamProvider getProviderOverride(
    covariant PumpStreamProvider provider,
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
  String? get name => r'pumpStreamProvider';
}

/// See also [pumpStream].
class PumpStreamProvider extends AutoDisposeStreamProvider<Pump?> {
  /// See also [pumpStream].
  PumpStreamProvider(
    String pumpId,
  ) : this._internal(
          (ref) => pumpStream(
            ref as PumpStreamRef,
            pumpId,
          ),
          from: pumpStreamProvider,
          name: r'pumpStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$pumpStreamHash,
          dependencies: PumpStreamFamily._dependencies,
          allTransitiveDependencies:
              PumpStreamFamily._allTransitiveDependencies,
          pumpId: pumpId,
        );

  PumpStreamProvider._internal(
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
    Stream<Pump?> Function(PumpStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PumpStreamProvider._internal(
        (ref) => create(ref as PumpStreamRef),
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
  AutoDisposeStreamProviderElement<Pump?> createElement() {
    return _PumpStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PumpStreamProvider && other.pumpId == pumpId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pumpId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PumpStreamRef on AutoDisposeStreamProviderRef<Pump?> {
  /// The parameter `pumpId` of this provider.
  String get pumpId;
}

class _PumpStreamProviderElement extends AutoDisposeStreamProviderElement<Pump?>
    with PumpStreamRef {
  _PumpStreamProviderElement(super.provider);

  @override
  String get pumpId => (origin as PumpStreamProvider).pumpId;
}

String _$pumpFutureHash() => r'd7f7591682b4a5d8256e2d8a453c76fb14e4f0c6';

/// See also [pumpFuture].
@ProviderFor(pumpFuture)
const pumpFutureProvider = PumpFutureFamily();

/// See also [pumpFuture].
class PumpFutureFamily extends Family<AsyncValue<Pump?>> {
  /// See also [pumpFuture].
  const PumpFutureFamily();

  /// See also [pumpFuture].
  PumpFutureProvider call(
    String pumpId,
  ) {
    return PumpFutureProvider(
      pumpId,
    );
  }

  @override
  PumpFutureProvider getProviderOverride(
    covariant PumpFutureProvider provider,
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
  String? get name => r'pumpFutureProvider';
}

/// See also [pumpFuture].
class PumpFutureProvider extends AutoDisposeFutureProvider<Pump?> {
  /// See also [pumpFuture].
  PumpFutureProvider(
    String pumpId,
  ) : this._internal(
          (ref) => pumpFuture(
            ref as PumpFutureRef,
            pumpId,
          ),
          from: pumpFutureProvider,
          name: r'pumpFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$pumpFutureHash,
          dependencies: PumpFutureFamily._dependencies,
          allTransitiveDependencies:
              PumpFutureFamily._allTransitiveDependencies,
          pumpId: pumpId,
        );

  PumpFutureProvider._internal(
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
    FutureOr<Pump?> Function(PumpFutureRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PumpFutureProvider._internal(
        (ref) => create(ref as PumpFutureRef),
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
  AutoDisposeFutureProviderElement<Pump?> createElement() {
    return _PumpFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PumpFutureProvider && other.pumpId == pumpId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pumpId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PumpFutureRef on AutoDisposeFutureProviderRef<Pump?> {
  /// The parameter `pumpId` of this provider.
  String get pumpId;
}

class _PumpFutureProviderElement extends AutoDisposeFutureProviderElement<Pump?>
    with PumpFutureRef {
  _PumpFutureProviderElement(super.provider);

  @override
  String get pumpId => (origin as PumpFutureProvider).pumpId;
}

String _$companyUsedPumpNamesStreamHash() =>
    r'd0a600288e6f5421f6fe831f814ff8cf88c30b42';

/// See also [companyUsedPumpNamesStream].
@ProviderFor(companyUsedPumpNamesStream)
final companyUsedPumpNamesStreamProvider =
    AutoDisposeStreamProvider<List<String?>>.internal(
  companyUsedPumpNamesStream,
  name: r'companyUsedPumpNamesStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$companyUsedPumpNamesStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CompanyUsedPumpNamesStreamRef
    = AutoDisposeStreamProviderRef<List<String?>>;
String _$companyUsedPumpOnCommandsStreamHash() =>
    r'57cf874cb3ebe37b40fb7fe6a8cd995bb0c01ae4';

/// See also [companyUsedPumpOnCommandsStream].
@ProviderFor(companyUsedPumpOnCommandsStream)
final companyUsedPumpOnCommandsStreamProvider =
    AutoDisposeStreamProvider<List<String?>>.internal(
  companyUsedPumpOnCommandsStream,
  name: r'companyUsedPumpOnCommandsStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$companyUsedPumpOnCommandsStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CompanyUsedPumpOnCommandsStreamRef
    = AutoDisposeStreamProviderRef<List<String?>>;
String _$companyUsedPumpOffCommandsStreamHash() =>
    r'6fa46b2f1996dea2e9284d9f20732dfb44689f1a';

/// See also [companyUsedPumpOffCommandsStream].
@ProviderFor(companyUsedPumpOffCommandsStream)
final companyUsedPumpOffCommandsStreamProvider =
    AutoDisposeStreamProvider<List<String?>>.internal(
  companyUsedPumpOffCommandsStream,
  name: r'companyUsedPumpOffCommandsStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$companyUsedPumpOffCommandsStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CompanyUsedPumpOffCommandsStreamRef
    = AutoDisposeStreamProviderRef<List<String?>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
