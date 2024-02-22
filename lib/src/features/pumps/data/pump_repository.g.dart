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
String _$watchCompanyPumpsHash() => r'7f59f85b06053b9ce88adac33726d5c9c07079c3';

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

/// See also [watchCompanyPumps].
@ProviderFor(watchCompanyPumps)
const watchCompanyPumpsProvider = WatchCompanyPumpsFamily();

/// See also [watchCompanyPumps].
class WatchCompanyPumpsFamily extends Family<AsyncValue<List<Pump>>> {
  /// See also [watchCompanyPumps].
  const WatchCompanyPumpsFamily();

  /// See also [watchCompanyPumps].
  WatchCompanyPumpsProvider call(
    String companyId,
  ) {
    return WatchCompanyPumpsProvider(
      companyId,
    );
  }

  @override
  WatchCompanyPumpsProvider getProviderOverride(
    covariant WatchCompanyPumpsProvider provider,
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
  String? get name => r'watchCompanyPumpsProvider';
}

/// See also [watchCompanyPumps].
class WatchCompanyPumpsProvider extends AutoDisposeStreamProvider<List<Pump>> {
  /// See also [watchCompanyPumps].
  WatchCompanyPumpsProvider(
    String companyId,
  ) : this._internal(
          (ref) => watchCompanyPumps(
            ref as WatchCompanyPumpsRef,
            companyId,
          ),
          from: watchCompanyPumpsProvider,
          name: r'watchCompanyPumpsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$watchCompanyPumpsHash,
          dependencies: WatchCompanyPumpsFamily._dependencies,
          allTransitiveDependencies:
              WatchCompanyPumpsFamily._allTransitiveDependencies,
          companyId: companyId,
        );

  WatchCompanyPumpsProvider._internal(
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
    Stream<List<Pump>> Function(WatchCompanyPumpsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WatchCompanyPumpsProvider._internal(
        (ref) => create(ref as WatchCompanyPumpsRef),
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
    return _WatchCompanyPumpsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WatchCompanyPumpsProvider && other.companyId == companyId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, companyId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WatchCompanyPumpsRef on AutoDisposeStreamProviderRef<List<Pump>> {
  /// The parameter `companyId` of this provider.
  String get companyId;
}

class _WatchCompanyPumpsProviderElement
    extends AutoDisposeStreamProviderElement<List<Pump>>
    with WatchCompanyPumpsRef {
  _WatchCompanyPumpsProviderElement(super.provider);

  @override
  String get companyId => (origin as WatchCompanyPumpsProvider).companyId;
}

String _$getCompanyPumpsHash() => r'7489fc308229fe164d163992a439fa5618432b51';

/// See also [getCompanyPumps].
@ProviderFor(getCompanyPumps)
const getCompanyPumpsProvider = GetCompanyPumpsFamily();

/// See also [getCompanyPumps].
class GetCompanyPumpsFamily extends Family<AsyncValue<List<Pump>>> {
  /// See also [getCompanyPumps].
  const GetCompanyPumpsFamily();

  /// See also [getCompanyPumps].
  GetCompanyPumpsProvider call(
    String companyId,
  ) {
    return GetCompanyPumpsProvider(
      companyId,
    );
  }

  @override
  GetCompanyPumpsProvider getProviderOverride(
    covariant GetCompanyPumpsProvider provider,
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
  String? get name => r'getCompanyPumpsProvider';
}

/// See also [getCompanyPumps].
class GetCompanyPumpsProvider extends AutoDisposeFutureProvider<List<Pump>> {
  /// See also [getCompanyPumps].
  GetCompanyPumpsProvider(
    String companyId,
  ) : this._internal(
          (ref) => getCompanyPumps(
            ref as GetCompanyPumpsRef,
            companyId,
          ),
          from: getCompanyPumpsProvider,
          name: r'getCompanyPumpsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getCompanyPumpsHash,
          dependencies: GetCompanyPumpsFamily._dependencies,
          allTransitiveDependencies:
              GetCompanyPumpsFamily._allTransitiveDependencies,
          companyId: companyId,
        );

  GetCompanyPumpsProvider._internal(
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
    FutureOr<List<Pump>> Function(GetCompanyPumpsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetCompanyPumpsProvider._internal(
        (ref) => create(ref as GetCompanyPumpsRef),
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
    return _GetCompanyPumpsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetCompanyPumpsProvider && other.companyId == companyId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, companyId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetCompanyPumpsRef on AutoDisposeFutureProviderRef<List<Pump>> {
  /// The parameter `companyId` of this provider.
  String get companyId;
}

class _GetCompanyPumpsProviderElement
    extends AutoDisposeFutureProviderElement<List<Pump>>
    with GetCompanyPumpsRef {
  _GetCompanyPumpsProviderElement(super.provider);

  @override
  String get companyId => (origin as GetCompanyPumpsProvider).companyId;
}

String _$watchPumpStatusHash() => r'8454dd43643bc3992e072f9ed76d28cb2db67d4f';

/// See also [watchPumpStatus].
@ProviderFor(watchPumpStatus)
const watchPumpStatusProvider = WatchPumpStatusFamily();

/// See also [watchPumpStatus].
class WatchPumpStatusFamily extends Family<AsyncValue<bool>> {
  /// See also [watchPumpStatus].
  const WatchPumpStatusFamily();

  /// See also [watchPumpStatus].
  WatchPumpStatusProvider call(
    String pumpId,
  ) {
    return WatchPumpStatusProvider(
      pumpId,
    );
  }

  @override
  WatchPumpStatusProvider getProviderOverride(
    covariant WatchPumpStatusProvider provider,
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
  String? get name => r'watchPumpStatusProvider';
}

/// See also [watchPumpStatus].
class WatchPumpStatusProvider extends AutoDisposeStreamProvider<bool> {
  /// See also [watchPumpStatus].
  WatchPumpStatusProvider(
    String pumpId,
  ) : this._internal(
          (ref) => watchPumpStatus(
            ref as WatchPumpStatusRef,
            pumpId,
          ),
          from: watchPumpStatusProvider,
          name: r'watchPumpStatusProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$watchPumpStatusHash,
          dependencies: WatchPumpStatusFamily._dependencies,
          allTransitiveDependencies:
              WatchPumpStatusFamily._allTransitiveDependencies,
          pumpId: pumpId,
        );

  WatchPumpStatusProvider._internal(
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
    Stream<bool> Function(WatchPumpStatusRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WatchPumpStatusProvider._internal(
        (ref) => create(ref as WatchPumpStatusRef),
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
  AutoDisposeStreamProviderElement<bool> createElement() {
    return _WatchPumpStatusProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WatchPumpStatusProvider && other.pumpId == pumpId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pumpId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WatchPumpStatusRef on AutoDisposeStreamProviderRef<bool> {
  /// The parameter `pumpId` of this provider.
  String get pumpId;
}

class _WatchPumpStatusProviderElement
    extends AutoDisposeStreamProviderElement<bool> with WatchPumpStatusRef {
  _WatchPumpStatusProviderElement(super.provider);

  @override
  String get pumpId => (origin as WatchPumpStatusProvider).pumpId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
