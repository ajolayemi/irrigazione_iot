// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authRepositoryHash() => r'0f0aea8947c951d7946110cb9f6ecaa1ea21237b';

/// General auth repository provider
///
/// Copied from [authRepository].
@ProviderFor(authRepository)
final authRepositoryProvider = Provider<AuthRepository>.internal(
  authRepository,
  name: r'authRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthRepositoryRef = ProviderRef<AuthRepository>;
String _$authStateChangesHash() => r'70d96078e41cd44270b2118f16bcbed842f33064';

/// See also [authStateChanges].
@ProviderFor(authStateChanges)
final authStateChangesProvider = StreamProvider<AppUser?>.internal(
  authStateChanges,
  name: r'authStateChangesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authStateChangesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthStateChangesRef = StreamProviderRef<AppUser?>;
String _$watchUserWithEmailHash() =>
    r'02f3f964793917d69dd48706438eec540389de93';

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

/// See also [watchUserWithEmail].
@ProviderFor(watchUserWithEmail)
const watchUserWithEmailProvider = WatchUserWithEmailFamily();

/// See also [watchUserWithEmail].
class WatchUserWithEmailFamily extends Family<AsyncValue<AppUser?>> {
  /// See also [watchUserWithEmail].
  const WatchUserWithEmailFamily();

  /// See also [watchUserWithEmail].
  WatchUserWithEmailProvider call(
    String email,
  ) {
    return WatchUserWithEmailProvider(
      email,
    );
  }

  @override
  WatchUserWithEmailProvider getProviderOverride(
    covariant WatchUserWithEmailProvider provider,
  ) {
    return call(
      provider.email,
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
  String? get name => r'watchUserWithEmailProvider';
}

/// See also [watchUserWithEmail].
class WatchUserWithEmailProvider extends AutoDisposeStreamProvider<AppUser?> {
  /// See also [watchUserWithEmail].
  WatchUserWithEmailProvider(
    String email,
  ) : this._internal(
          (ref) => watchUserWithEmail(
            ref as WatchUserWithEmailRef,
            email,
          ),
          from: watchUserWithEmailProvider,
          name: r'watchUserWithEmailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$watchUserWithEmailHash,
          dependencies: WatchUserWithEmailFamily._dependencies,
          allTransitiveDependencies:
              WatchUserWithEmailFamily._allTransitiveDependencies,
          email: email,
        );

  WatchUserWithEmailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.email,
  }) : super.internal();

  final String email;

  @override
  Override overrideWith(
    Stream<AppUser?> Function(WatchUserWithEmailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WatchUserWithEmailProvider._internal(
        (ref) => create(ref as WatchUserWithEmailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        email: email,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<AppUser?> createElement() {
    return _WatchUserWithEmailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WatchUserWithEmailProvider && other.email == email;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, email.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WatchUserWithEmailRef on AutoDisposeStreamProviderRef<AppUser?> {
  /// The parameter `email` of this provider.
  String get email;
}

class _WatchUserWithEmailProviderElement
    extends AutoDisposeStreamProviderElement<AppUser?>
    with WatchUserWithEmailRef {
  _WatchUserWithEmailProviderElement(super.provider);

  @override
  String get email => (origin as WatchUserWithEmailProvider).email;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
