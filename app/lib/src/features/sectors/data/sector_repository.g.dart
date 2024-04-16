// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sector_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sectorRepositoryHash() => r'5a2329c3480807a5709e7698b2caea4c793b2667';

/// See also [sectorRepository].
@ProviderFor(sectorRepository)
final sectorRepositoryProvider = Provider<SectorRepository>.internal(
  sectorRepository,
  name: r'sectorRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sectorRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SectorRepositoryRef = ProviderRef<SectorRepository>;
String _$sectorListStreamHash() => r'382742696799ce2f968c1f51e357a198208d5607';

/// See also [sectorListStream].
@ProviderFor(sectorListStream)
final sectorListStreamProvider =
    AutoDisposeStreamProvider<List<Sector?>>.internal(
  sectorListStream,
  name: r'sectorListStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sectorListStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SectorListStreamRef = AutoDisposeStreamProviderRef<List<Sector?>>;
String _$sectorListFutureHash() => r'e0bc6bc737733d5b091ed5ae83b2015dacd8e8cf';

/// See also [sectorListFuture].
@ProviderFor(sectorListFuture)
final sectorListFutureProvider =
    AutoDisposeFutureProvider<List<Sector?>>.internal(
  sectorListFuture,
  name: r'sectorListFutureProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sectorListFutureHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SectorListFutureRef = AutoDisposeFutureProviderRef<List<Sector?>>;
String _$sectorStreamHash() => r'e879a344390bb894612641b4434f575bf5229c65';

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

/// See also [sectorStream].
@ProviderFor(sectorStream)
const sectorStreamProvider = SectorStreamFamily();

/// See also [sectorStream].
class SectorStreamFamily extends Family<AsyncValue<Sector?>> {
  /// See also [sectorStream].
  const SectorStreamFamily();

  /// See also [sectorStream].
  SectorStreamProvider call(
    String sectorID,
  ) {
    return SectorStreamProvider(
      sectorID,
    );
  }

  @override
  SectorStreamProvider getProviderOverride(
    covariant SectorStreamProvider provider,
  ) {
    return call(
      provider.sectorID,
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
  String? get name => r'sectorStreamProvider';
}

/// See also [sectorStream].
class SectorStreamProvider extends AutoDisposeStreamProvider<Sector?> {
  /// See also [sectorStream].
  SectorStreamProvider(
    String sectorID,
  ) : this._internal(
          (ref) => sectorStream(
            ref as SectorStreamRef,
            sectorID,
          ),
          from: sectorStreamProvider,
          name: r'sectorStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sectorStreamHash,
          dependencies: SectorStreamFamily._dependencies,
          allTransitiveDependencies:
              SectorStreamFamily._allTransitiveDependencies,
          sectorID: sectorID,
        );

  SectorStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.sectorID,
  }) : super.internal();

  final String sectorID;

  @override
  Override overrideWith(
    Stream<Sector?> Function(SectorStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SectorStreamProvider._internal(
        (ref) => create(ref as SectorStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        sectorID: sectorID,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Sector?> createElement() {
    return _SectorStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SectorStreamProvider && other.sectorID == sectorID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sectorID.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SectorStreamRef on AutoDisposeStreamProviderRef<Sector?> {
  /// The parameter `sectorID` of this provider.
  String get sectorID;
}

class _SectorStreamProviderElement
    extends AutoDisposeStreamProviderElement<Sector?> with SectorStreamRef {
  _SectorStreamProviderElement(super.provider);

  @override
  String get sectorID => (origin as SectorStreamProvider).sectorID;
}

String _$sectorFutureHash() => r'24393a74de519316085a83cfcb076951b35f106d';

/// See also [sectorFuture].
@ProviderFor(sectorFuture)
const sectorFutureProvider = SectorFutureFamily();

/// See also [sectorFuture].
class SectorFutureFamily extends Family<AsyncValue<Sector?>> {
  /// See also [sectorFuture].
  const SectorFutureFamily();

  /// See also [sectorFuture].
  SectorFutureProvider call(
    String sectorID,
  ) {
    return SectorFutureProvider(
      sectorID,
    );
  }

  @override
  SectorFutureProvider getProviderOverride(
    covariant SectorFutureProvider provider,
  ) {
    return call(
      provider.sectorID,
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
  String? get name => r'sectorFutureProvider';
}

/// See also [sectorFuture].
class SectorFutureProvider extends AutoDisposeFutureProvider<Sector?> {
  /// See also [sectorFuture].
  SectorFutureProvider(
    String sectorID,
  ) : this._internal(
          (ref) => sectorFuture(
            ref as SectorFutureRef,
            sectorID,
          ),
          from: sectorFutureProvider,
          name: r'sectorFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sectorFutureHash,
          dependencies: SectorFutureFamily._dependencies,
          allTransitiveDependencies:
              SectorFutureFamily._allTransitiveDependencies,
          sectorID: sectorID,
        );

  SectorFutureProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.sectorID,
  }) : super.internal();

  final String sectorID;

  @override
  Override overrideWith(
    FutureOr<Sector?> Function(SectorFutureRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SectorFutureProvider._internal(
        (ref) => create(ref as SectorFutureRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        sectorID: sectorID,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Sector?> createElement() {
    return _SectorFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SectorFutureProvider && other.sectorID == sectorID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sectorID.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SectorFutureRef on AutoDisposeFutureProviderRef<Sector?> {
  /// The parameter `sectorID` of this provider.
  String get sectorID;
}

class _SectorFutureProviderElement
    extends AutoDisposeFutureProviderElement<Sector?> with SectorFutureRef {
  _SectorFutureProviderElement(super.provider);

  @override
  String get sectorID => (origin as SectorFutureProvider).sectorID;
}

String _$usedSectorNamesStreamHash() =>
    r'5e50177ba9d06111a302162f2183d01eca4ba821';

/// See also [usedSectorNamesStream].
@ProviderFor(usedSectorNamesStream)
final usedSectorNamesStreamProvider =
    AutoDisposeStreamProvider<List<String?>>.internal(
  usedSectorNamesStream,
  name: r'usedSectorNamesStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$usedSectorNamesStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UsedSectorNamesStreamRef = AutoDisposeStreamProviderRef<List<String?>>;
String _$usedSectorOnCommandsStreamHash() =>
    r'4eaa224892af89ac39a7d2830a307c62fe5c52e8';

/// See also [usedSectorOnCommandsStream].
@ProviderFor(usedSectorOnCommandsStream)
final usedSectorOnCommandsStreamProvider =
    AutoDisposeStreamProvider<List<String?>>.internal(
  usedSectorOnCommandsStream,
  name: r'usedSectorOnCommandsStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$usedSectorOnCommandsStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UsedSectorOnCommandsStreamRef
    = AutoDisposeStreamProviderRef<List<String?>>;
String _$usedSectorOffCommandsStreamHash() =>
    r'89a702141679dd5a885097bf128db308ba63a579';

/// See also [usedSectorOffCommandsStream].
@ProviderFor(usedSectorOffCommandsStream)
final usedSectorOffCommandsStreamProvider =
    AutoDisposeStreamProvider<List<String?>>.internal(
  usedSectorOffCommandsStream,
  name: r'usedSectorOffCommandsStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$usedSectorOffCommandsStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UsedSectorOffCommandsStreamRef
    = AutoDisposeStreamProviderRef<List<String?>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
