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
    r'52e3ec03da4b7b167d52edae64420f4c48eb763d';

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

/// See also [companyPumpsStream].
@ProviderFor(companyPumpsStream)
const companyPumpsStreamProvider = CompanyPumpsStreamFamily();

/// See also [companyPumpsStream].
class CompanyPumpsStreamFamily extends Family<AsyncValue<List<Pump>>> {
  /// See also [companyPumpsStream].
  const CompanyPumpsStreamFamily();

  /// See also [companyPumpsStream].
  CompanyPumpsStreamProvider call(
    String companyId,
  ) {
    return CompanyPumpsStreamProvider(
      companyId,
    );
  }

  @override
  CompanyPumpsStreamProvider getProviderOverride(
    covariant CompanyPumpsStreamProvider provider,
  ) {
    return call(
      provider.companyId,
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
  String? get name => r'companyPumpsStreamProvider';
}

/// See also [companyPumpsStream].
class CompanyPumpsStreamProvider extends AutoDisposeStreamProvider<List<Pump>> {
  /// See also [companyPumpsStream].
  CompanyPumpsStreamProvider(
    String companyId,
  ) : this._internal(
          (ref) => companyPumpsStream(
            ref as CompanyPumpsStreamRef,
            companyId,
          ),
          from: companyPumpsStreamProvider,
          name: r'companyPumpsStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$companyPumpsStreamHash,
          dependencies: CompanyPumpsStreamFamily._dependencies,
          allTransitiveDependencies:
              CompanyPumpsStreamFamily._allTransitiveDependencies,
          companyId: companyId,
        );

  CompanyPumpsStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.companyId,
  }) : super.internal();

  final String companyId;

  @override
  Override overrideWith(
    Stream<List<Pump>> Function(CompanyPumpsStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CompanyPumpsStreamProvider._internal(
        (ref) => create(ref as CompanyPumpsStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        companyId: companyId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Pump>> createElement() {
    return _CompanyPumpsStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CompanyPumpsStreamProvider && other.companyId == companyId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, companyId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CompanyPumpsStreamRef on AutoDisposeStreamProviderRef<List<Pump>> {
  /// The parameter `companyId` of this provider.
  String get companyId;
}

class _CompanyPumpsStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<Pump>>
    with CompanyPumpsStreamRef {
  _CompanyPumpsStreamProviderElement(super.provider);

  @override
  String get companyId => (origin as CompanyPumpsStreamProvider).companyId;
}

String _$companyPumpsFutureHash() =>
    r'e8e8dcf2a0699d950638ce8deab42463e73e90e3';

/// See also [companyPumpsFuture].
@ProviderFor(companyPumpsFuture)
const companyPumpsFutureProvider = CompanyPumpsFutureFamily();

/// See also [companyPumpsFuture].
class CompanyPumpsFutureFamily extends Family<AsyncValue<List<Pump>>> {
  /// See also [companyPumpsFuture].
  const CompanyPumpsFutureFamily();

  /// See also [companyPumpsFuture].
  CompanyPumpsFutureProvider call(
    String companyId,
  ) {
    return CompanyPumpsFutureProvider(
      companyId,
    );
  }

  @override
  CompanyPumpsFutureProvider getProviderOverride(
    covariant CompanyPumpsFutureProvider provider,
  ) {
    return call(
      provider.companyId,
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
  String? get name => r'companyPumpsFutureProvider';
}

/// See also [companyPumpsFuture].
class CompanyPumpsFutureProvider extends AutoDisposeFutureProvider<List<Pump>> {
  /// See also [companyPumpsFuture].
  CompanyPumpsFutureProvider(
    String companyId,
  ) : this._internal(
          (ref) => companyPumpsFuture(
            ref as CompanyPumpsFutureRef,
            companyId,
          ),
          from: companyPumpsFutureProvider,
          name: r'companyPumpsFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$companyPumpsFutureHash,
          dependencies: CompanyPumpsFutureFamily._dependencies,
          allTransitiveDependencies:
              CompanyPumpsFutureFamily._allTransitiveDependencies,
          companyId: companyId,
        );

  CompanyPumpsFutureProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.companyId,
  }) : super.internal();

  final String companyId;

  @override
  Override overrideWith(
    FutureOr<List<Pump>> Function(CompanyPumpsFutureRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CompanyPumpsFutureProvider._internal(
        (ref) => create(ref as CompanyPumpsFutureRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        companyId: companyId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Pump>> createElement() {
    return _CompanyPumpsFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CompanyPumpsFutureProvider && other.companyId == companyId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, companyId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CompanyPumpsFutureRef on AutoDisposeFutureProviderRef<List<Pump>> {
  /// The parameter `companyId` of this provider.
  String get companyId;
}

class _CompanyPumpsFutureProviderElement
    extends AutoDisposeFutureProviderElement<List<Pump>>
    with CompanyPumpsFutureRef {
  _CompanyPumpsFutureProviderElement(super.provider);

  @override
  String get companyId => (origin as CompanyPumpsFutureProvider).companyId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
