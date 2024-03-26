// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_users_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$companyUsersRepositoryHash() =>
    r'd541cecdea41c3d236bf4b0014d2833be585e317';

/// See also [companyUsersRepository].
@ProviderFor(companyUsersRepository)
final companyUsersRepositoryProvider =
    Provider<CompanyUsersRepository>.internal(
  companyUsersRepository,
  name: r'companyUsersRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$companyUsersRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CompanyUsersRepositoryRef = ProviderRef<CompanyUsersRepository>;
String _$userCompaniesFutureHash() =>
    r'8f1767b8c67e2b951ce38a4d036ebd1f294fb025';

/// See also [userCompaniesFuture].
@ProviderFor(userCompaniesFuture)
final userCompaniesFutureProvider =
    AutoDisposeFutureProvider<List<Company>>.internal(
  userCompaniesFuture,
  name: r'userCompaniesFutureProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userCompaniesFutureHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserCompaniesFutureRef = AutoDisposeFutureProviderRef<List<Company>>;
String _$userCompaniesStreamHash() =>
    r'9795ccbcc6b98c8ba8b9321cb0dc751e262fca05';

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
String _$companyUserRoleHash() => r'4090a5b1c2a1aa562f6d629cbf0235f82ee0c3bc';

/// See also [companyUserRole].
@ProviderFor(companyUserRole)
final companyUserRoleProvider = StreamProvider<CompanyUserRoles?>.internal(
  companyUserRole,
  name: r'companyUserRoleProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$companyUserRoleHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CompanyUserRoleRef = StreamProviderRef<CompanyUserRoles?>;
String _$usersAssociatedWithCompanyStreamHash() =>
    r'cd02b46aa677e9bae1e734c0ed33a71632d4f6ab';

/// See also [usersAssociatedWithCompanyStream].
@ProviderFor(usersAssociatedWithCompanyStream)
final usersAssociatedWithCompanyStreamProvider =
    AutoDisposeStreamProvider<List<CompanyUser?>>.internal(
  usersAssociatedWithCompanyStream,
  name: r'usersAssociatedWithCompanyStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$usersAssociatedWithCompanyStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UsersAssociatedWithCompanyStreamRef
    = AutoDisposeStreamProviderRef<List<CompanyUser?>>;
String _$companyUserStreamHash() => r'04698083d0d53272229d4cb552c11be0da092bfc';

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

/// See also [companyUserStream].
@ProviderFor(companyUserStream)
const companyUserStreamProvider = CompanyUserStreamFamily();

/// See also [companyUserStream].
class CompanyUserStreamFamily extends Family<AsyncValue<CompanyUser?>> {
  /// See also [companyUserStream].
  const CompanyUserStreamFamily();

  /// See also [companyUserStream].
  CompanyUserStreamProvider call({
    required String companyUserId,
  }) {
    return CompanyUserStreamProvider(
      companyUserId: companyUserId,
    );
  }

  @override
  CompanyUserStreamProvider getProviderOverride(
    covariant CompanyUserStreamProvider provider,
  ) {
    return call(
      companyUserId: provider.companyUserId,
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
  String? get name => r'companyUserStreamProvider';
}

/// See also [companyUserStream].
class CompanyUserStreamProvider
    extends AutoDisposeStreamProvider<CompanyUser?> {
  /// See also [companyUserStream].
  CompanyUserStreamProvider({
    required String companyUserId,
  }) : this._internal(
          (ref) => companyUserStream(
            ref as CompanyUserStreamRef,
            companyUserId: companyUserId,
          ),
          from: companyUserStreamProvider,
          name: r'companyUserStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$companyUserStreamHash,
          dependencies: CompanyUserStreamFamily._dependencies,
          allTransitiveDependencies:
              CompanyUserStreamFamily._allTransitiveDependencies,
          companyUserId: companyUserId,
        );

  CompanyUserStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.companyUserId,
  }) : super.internal();

  final String companyUserId;

  @override
  Override overrideWith(
    Stream<CompanyUser?> Function(CompanyUserStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CompanyUserStreamProvider._internal(
        (ref) => create(ref as CompanyUserStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        companyUserId: companyUserId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<CompanyUser?> createElement() {
    return _CompanyUserStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CompanyUserStreamProvider &&
        other.companyUserId == companyUserId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, companyUserId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CompanyUserStreamRef on AutoDisposeStreamProviderRef<CompanyUser?> {
  /// The parameter `companyUserId` of this provider.
  String get companyUserId;
}

class _CompanyUserStreamProviderElement
    extends AutoDisposeStreamProviderElement<CompanyUser?>
    with CompanyUserStreamRef {
  _CompanyUserStreamProviderElement(super.provider);

  @override
  String get companyUserId =>
      (origin as CompanyUserStreamProvider).companyUserId;
}

String _$emailsAssociatedWithCompanyStreamHash() =>
    r'cee2d6dab360dd9d7260a9aa4adeb322835bdd94';

/// See also [emailsAssociatedWithCompanyStream].
@ProviderFor(emailsAssociatedWithCompanyStream)
final emailsAssociatedWithCompanyStreamProvider =
    AutoDisposeStreamProvider<List<String>>.internal(
  emailsAssociatedWithCompanyStream,
  name: r'emailsAssociatedWithCompanyStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$emailsAssociatedWithCompanyStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef EmailsAssociatedWithCompanyStreamRef
    = AutoDisposeStreamProviderRef<List<String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
