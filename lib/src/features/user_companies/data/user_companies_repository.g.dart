// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_companies_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userCompaniesRepositoryHash() =>
    r'08e34e2a1bf3b80f451fe3cf7728f787c4966c55';

/// See also [userCompaniesRepository].
@ProviderFor(userCompaniesRepository)
final userCompaniesRepositoryProvider =
    Provider<UserCompaniesRepository>.internal(
  userCompaniesRepository,
  name: r'userCompaniesRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userCompaniesRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserCompaniesRepositoryRef = ProviderRef<UserCompaniesRepository>;
String _$userCompaniesFutureHash() =>
    r'33843c79feb8a767954fdf68559ddaf4193e2f34';

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

/// See also [userCompaniesFuture].
@ProviderFor(userCompaniesFuture)
const userCompaniesFutureProvider = UserCompaniesFutureFamily();

/// See also [userCompaniesFuture].
class UserCompaniesFutureFamily extends Family<AsyncValue<List<Company>>> {
  /// See also [userCompaniesFuture].
  const UserCompaniesFutureFamily();

  /// See also [userCompaniesFuture].
  UserCompaniesFutureProvider call(
    String userId,
  ) {
    return UserCompaniesFutureProvider(
      userId,
    );
  }

  @override
  UserCompaniesFutureProvider getProviderOverride(
    covariant UserCompaniesFutureProvider provider,
  ) {
    return call(
      provider.userId,
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
  String? get name => r'userCompaniesFutureProvider';
}

/// See also [userCompaniesFuture].
class UserCompaniesFutureProvider
    extends AutoDisposeFutureProvider<List<Company>> {
  /// See also [userCompaniesFuture].
  UserCompaniesFutureProvider(
    String userId,
  ) : this._internal(
          (ref) => userCompaniesFuture(
            ref as UserCompaniesFutureRef,
            userId,
          ),
          from: userCompaniesFutureProvider,
          name: r'userCompaniesFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userCompaniesFutureHash,
          dependencies: UserCompaniesFutureFamily._dependencies,
          allTransitiveDependencies:
              UserCompaniesFutureFamily._allTransitiveDependencies,
          userId: userId,
        );

  UserCompaniesFutureProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    FutureOr<List<Company>> Function(UserCompaniesFutureRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserCompaniesFutureProvider._internal(
        (ref) => create(ref as UserCompaniesFutureRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Company>> createElement() {
    return _UserCompaniesFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserCompaniesFutureProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UserCompaniesFutureRef on AutoDisposeFutureProviderRef<List<Company>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _UserCompaniesFutureProviderElement
    extends AutoDisposeFutureProviderElement<List<Company>>
    with UserCompaniesFutureRef {
  _UserCompaniesFutureProviderElement(super.provider);

  @override
  String get userId => (origin as UserCompaniesFutureProvider).userId;
}

String _$userCompaniesStreamHash() =>
    r'9d02386b0f35e3640b1d6b0afc4a0aeeef28953f';

/// See also [userCompaniesStream].
@ProviderFor(userCompaniesStream)
final userCompaniesStreamProvider =
    AutoDisposeStreamProvider<List<Company>>.internal(
  userCompaniesStream,
  name: r'userCompaniesStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userCompaniesStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserCompaniesStreamRef = AutoDisposeStreamProviderRef<List<Company>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
