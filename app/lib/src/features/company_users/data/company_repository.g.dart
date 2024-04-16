// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$companyRepositoryHash() => r'bac5b79d77df858d5004b5b705a2047a2c8f003d';

/// See also [companyRepository].
@ProviderFor(companyRepository)
final companyRepositoryProvider = Provider<CompanyRepository>.internal(
  companyRepository,
  name: r'companyRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$companyRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CompanyRepositoryRef = ProviderRef<CompanyRepository>;
String _$companyFutureHash() => r'3a499940fcc9834d75da96a96642adf97a61674c';

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

/// See also [companyFuture].
@ProviderFor(companyFuture)
const companyFutureProvider = CompanyFutureFamily();

/// See also [companyFuture].
class CompanyFutureFamily extends Family<AsyncValue<Company?>> {
  /// See also [companyFuture].
  const CompanyFutureFamily();

  /// See also [companyFuture].
  CompanyFutureProvider call(
    String companyId,
  ) {
    return CompanyFutureProvider(
      companyId,
    );
  }

  @override
  CompanyFutureProvider getProviderOverride(
    covariant CompanyFutureProvider provider,
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
  String? get name => r'companyFutureProvider';
}

/// See also [companyFuture].
class CompanyFutureProvider extends AutoDisposeFutureProvider<Company?> {
  /// See also [companyFuture].
  CompanyFutureProvider(
    String companyId,
  ) : this._internal(
          (ref) => companyFuture(
            ref as CompanyFutureRef,
            companyId,
          ),
          from: companyFutureProvider,
          name: r'companyFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$companyFutureHash,
          dependencies: CompanyFutureFamily._dependencies,
          allTransitiveDependencies:
              CompanyFutureFamily._allTransitiveDependencies,
          companyId: companyId,
        );

  CompanyFutureProvider._internal(
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
    FutureOr<Company?> Function(CompanyFutureRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CompanyFutureProvider._internal(
        (ref) => create(ref as CompanyFutureRef),
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
  AutoDisposeFutureProviderElement<Company?> createElement() {
    return _CompanyFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CompanyFutureProvider && other.companyId == companyId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, companyId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CompanyFutureRef on AutoDisposeFutureProviderRef<Company?> {
  /// The parameter `companyId` of this provider.
  String get companyId;
}

class _CompanyFutureProviderElement
    extends AutoDisposeFutureProviderElement<Company?> with CompanyFutureRef {
  _CompanyFutureProviderElement(super.provider);

  @override
  String get companyId => (origin as CompanyFutureProvider).companyId;
}

String _$companyStreamHash() => r'39be41774e621ebd5f8fee24586c3e06385f50ff';

/// See also [companyStream].
@ProviderFor(companyStream)
const companyStreamProvider = CompanyStreamFamily();

/// See also [companyStream].
class CompanyStreamFamily extends Family<AsyncValue<Company?>> {
  /// See also [companyStream].
  const CompanyStreamFamily();

  /// See also [companyStream].
  CompanyStreamProvider call(
    String companyId,
  ) {
    return CompanyStreamProvider(
      companyId,
    );
  }

  @override
  CompanyStreamProvider getProviderOverride(
    covariant CompanyStreamProvider provider,
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
  String? get name => r'companyStreamProvider';
}

/// See also [companyStream].
class CompanyStreamProvider extends AutoDisposeStreamProvider<Company?> {
  /// See also [companyStream].
  CompanyStreamProvider(
    String companyId,
  ) : this._internal(
          (ref) => companyStream(
            ref as CompanyStreamRef,
            companyId,
          ),
          from: companyStreamProvider,
          name: r'companyStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$companyStreamHash,
          dependencies: CompanyStreamFamily._dependencies,
          allTransitiveDependencies:
              CompanyStreamFamily._allTransitiveDependencies,
          companyId: companyId,
        );

  CompanyStreamProvider._internal(
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
    Stream<Company?> Function(CompanyStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CompanyStreamProvider._internal(
        (ref) => create(ref as CompanyStreamRef),
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
  AutoDisposeStreamProviderElement<Company?> createElement() {
    return _CompanyStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CompanyStreamProvider && other.companyId == companyId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, companyId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CompanyStreamRef on AutoDisposeStreamProviderRef<Company?> {
  /// The parameter `companyId` of this provider.
  String get companyId;
}

class _CompanyStreamProviderElement
    extends AutoDisposeStreamProviderElement<Company?> with CompanyStreamRef {
  _CompanyStreamProviderElement(super.provider);

  @override
  String get companyId => (origin as CompanyStreamProvider).companyId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
