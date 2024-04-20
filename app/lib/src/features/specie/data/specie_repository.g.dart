// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specie_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$specieRepositoryHash() => r'ce7222393e0ff969bd57baf11855f16db3806f08';

/// See also [specieRepository].
@ProviderFor(specieRepository)
final specieRepositoryProvider = Provider<SpecieRepository>.internal(
  specieRepository,
  name: r'specieRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$specieRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SpecieRepositoryRef = ProviderRef<SpecieRepository>;
String _$speciesStreamHash() => r'34ecf90eaf76a714843cd457f76ef020fca081e0';

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

/// See also [speciesStream].
@ProviderFor(speciesStream)
const speciesStreamProvider = SpeciesStreamFamily();

/// See also [speciesStream].
class SpeciesStreamFamily extends Family<AsyncValue<List<Specie>?>> {
  /// See also [speciesStream].
  const SpeciesStreamFamily();

  /// See also [speciesStream].
  SpeciesStreamProvider call({
    String? previouslySelectedSpecieId,
  }) {
    return SpeciesStreamProvider(
      previouslySelectedSpecieId: previouslySelectedSpecieId,
    );
  }

  @override
  SpeciesStreamProvider getProviderOverride(
    covariant SpeciesStreamProvider provider,
  ) {
    return call(
      previouslySelectedSpecieId: provider.previouslySelectedSpecieId,
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
  String? get name => r'speciesStreamProvider';
}

/// See also [speciesStream].
class SpeciesStreamProvider extends AutoDisposeStreamProvider<List<Specie>?> {
  /// See also [speciesStream].
  SpeciesStreamProvider({
    String? previouslySelectedSpecieId,
  }) : this._internal(
          (ref) => speciesStream(
            ref as SpeciesStreamRef,
            previouslySelectedSpecieId: previouslySelectedSpecieId,
          ),
          from: speciesStreamProvider,
          name: r'speciesStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$speciesStreamHash,
          dependencies: SpeciesStreamFamily._dependencies,
          allTransitiveDependencies:
              SpeciesStreamFamily._allTransitiveDependencies,
          previouslySelectedSpecieId: previouslySelectedSpecieId,
        );

  SpeciesStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.previouslySelectedSpecieId,
  }) : super.internal();

  final String? previouslySelectedSpecieId;

  @override
  Override overrideWith(
    Stream<List<Specie>?> Function(SpeciesStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SpeciesStreamProvider._internal(
        (ref) => create(ref as SpeciesStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        previouslySelectedSpecieId: previouslySelectedSpecieId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Specie>?> createElement() {
    return _SpeciesStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SpeciesStreamProvider &&
        other.previouslySelectedSpecieId == previouslySelectedSpecieId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, previouslySelectedSpecieId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SpeciesStreamRef on AutoDisposeStreamProviderRef<List<Specie>?> {
  /// The parameter `previouslySelectedSpecieId` of this provider.
  String? get previouslySelectedSpecieId;
}

class _SpeciesStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<Specie>?>
    with SpeciesStreamRef {
  _SpeciesStreamProviderElement(super.provider);

  @override
  String? get previouslySelectedSpecieId =>
      (origin as SpeciesStreamProvider).previouslySelectedSpecieId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
