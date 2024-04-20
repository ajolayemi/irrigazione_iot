// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variety_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$varietyRepositoryHash() => r'cd243160ad9de9259fda501e9b49fcd77fab4c1c';

/// See also [varietyRepository].
@ProviderFor(varietyRepository)
final varietyRepositoryProvider = Provider<VarietyRepository>.internal(
  varietyRepository,
  name: r'varietyRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$varietyRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef VarietyRepositoryRef = ProviderRef<VarietyRepository>;
String _$varietiesStreamHash() => r'9596324dbced73e226570bab83ede821c6acc675';

/// See also [varietiesStream].
@ProviderFor(varietiesStream)
final varietiesStreamProvider =
    AutoDisposeStreamProvider<List<Variety>?>.internal(
  varietiesStream,
  name: r'varietiesStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$varietiesStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef VarietiesStreamRef = AutoDisposeStreamProviderRef<List<Variety>?>;
String _$varietyStreamHash() => r'9fed81c2f1f779b367da07d21b20d0722461ffab';

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

/// See also [varietyStream].
@ProviderFor(varietyStream)
const varietyStreamProvider = VarietyStreamFamily();

/// See also [varietyStream].
class VarietyStreamFamily extends Family<AsyncValue<Variety?>> {
  /// See also [varietyStream].
  const VarietyStreamFamily();

  /// See also [varietyStream].
  VarietyStreamProvider call(
    String varietyId,
  ) {
    return VarietyStreamProvider(
      varietyId,
    );
  }

  @override
  VarietyStreamProvider getProviderOverride(
    covariant VarietyStreamProvider provider,
  ) {
    return call(
      provider.varietyId,
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
  String? get name => r'varietyStreamProvider';
}

/// See also [varietyStream].
class VarietyStreamProvider extends AutoDisposeStreamProvider<Variety?> {
  /// See also [varietyStream].
  VarietyStreamProvider(
    String varietyId,
  ) : this._internal(
          (ref) => varietyStream(
            ref as VarietyStreamRef,
            varietyId,
          ),
          from: varietyStreamProvider,
          name: r'varietyStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$varietyStreamHash,
          dependencies: VarietyStreamFamily._dependencies,
          allTransitiveDependencies:
              VarietyStreamFamily._allTransitiveDependencies,
          varietyId: varietyId,
        );

  VarietyStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.varietyId,
  }) : super.internal();

  final String varietyId;

  @override
  Override overrideWith(
    Stream<Variety?> Function(VarietyStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: VarietyStreamProvider._internal(
        (ref) => create(ref as VarietyStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        varietyId: varietyId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Variety?> createElement() {
    return _VarietyStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is VarietyStreamProvider && other.varietyId == varietyId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, varietyId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin VarietyStreamRef on AutoDisposeStreamProviderRef<Variety?> {
  /// The parameter `varietyId` of this provider.
  String get varietyId;
}

class _VarietyStreamProviderElement
    extends AutoDisposeStreamProviderElement<Variety?> with VarietyStreamRef {
  _VarietyStreamProviderElement(super.provider);

  @override
  String get varietyId => (origin as VarietyStreamProvider).varietyId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
