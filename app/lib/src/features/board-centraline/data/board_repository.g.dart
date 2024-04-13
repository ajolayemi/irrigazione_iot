// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$boardRepositoryHash() => r'7e457c0641c38884d246b54d163d6c567deeb939';

/// See also [boardRepository].
@ProviderFor(boardRepository)
final boardRepositoryProvider = Provider<BoardRepository>.internal(
  boardRepository,
  name: r'boardRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$boardRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef BoardRepositoryRef = ProviderRef<BoardRepository>;
String _$boardListStreamHash() => r'5d342fb3de301b8df7b73026b25a6e8781161fc0';

/// See also [boardListStream].
@ProviderFor(boardListStream)
final boardListStreamProvider =
    AutoDisposeStreamProvider<List<Board?>>.internal(
  boardListStream,
  name: r'boardListStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$boardListStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef BoardListStreamRef = AutoDisposeStreamProviderRef<List<Board?>>;
String _$boardListFutureHash() => r'138fa201400f29c3999150c4021ffbd4bdb1812d';

/// See also [boardListFuture].
@ProviderFor(boardListFuture)
final boardListFutureProvider =
    AutoDisposeFutureProvider<List<Board?>>.internal(
  boardListFuture,
  name: r'boardListFutureProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$boardListFutureHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef BoardListFutureRef = AutoDisposeFutureProviderRef<List<Board?>>;
String _$collectorBoardStreamHash() =>
    r'f0a301ef5c9e262e64d781aacd60eff0241881e7';

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

/// See also [collectorBoardStream].
@ProviderFor(collectorBoardStream)
const collectorBoardStreamProvider = CollectorBoardStreamFamily();

/// See also [collectorBoardStream].
class CollectorBoardStreamFamily extends Family<AsyncValue<Board?>> {
  /// See also [collectorBoardStream].
  const CollectorBoardStreamFamily();

  /// See also [collectorBoardStream].
  CollectorBoardStreamProvider call({
    required String collectorID,
  }) {
    return CollectorBoardStreamProvider(
      collectorID: collectorID,
    );
  }

  @override
  CollectorBoardStreamProvider getProviderOverride(
    covariant CollectorBoardStreamProvider provider,
  ) {
    return call(
      collectorID: provider.collectorID,
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
  String? get name => r'collectorBoardStreamProvider';
}

/// See also [collectorBoardStream].
class CollectorBoardStreamProvider extends AutoDisposeStreamProvider<Board?> {
  /// See also [collectorBoardStream].
  CollectorBoardStreamProvider({
    required String collectorID,
  }) : this._internal(
          (ref) => collectorBoardStream(
            ref as CollectorBoardStreamRef,
            collectorID: collectorID,
          ),
          from: collectorBoardStreamProvider,
          name: r'collectorBoardStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$collectorBoardStreamHash,
          dependencies: CollectorBoardStreamFamily._dependencies,
          allTransitiveDependencies:
              CollectorBoardStreamFamily._allTransitiveDependencies,
          collectorID: collectorID,
        );

  CollectorBoardStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.collectorID,
  }) : super.internal();

  final String collectorID;

  @override
  Override overrideWith(
    Stream<Board?> Function(CollectorBoardStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CollectorBoardStreamProvider._internal(
        (ref) => create(ref as CollectorBoardStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        collectorID: collectorID,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Board?> createElement() {
    return _CollectorBoardStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CollectorBoardStreamProvider &&
        other.collectorID == collectorID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, collectorID.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CollectorBoardStreamRef on AutoDisposeStreamProviderRef<Board?> {
  /// The parameter `collectorID` of this provider.
  String get collectorID;
}

class _CollectorBoardStreamProviderElement
    extends AutoDisposeStreamProviderElement<Board?>
    with CollectorBoardStreamRef {
  _CollectorBoardStreamProviderElement(super.provider);

  @override
  String get collectorID =>
      (origin as CollectorBoardStreamProvider).collectorID;
}

String _$collectorBoardFutureHash() =>
    r'4c1a2719e9fe1f7c5c25029a09b3aa38bfada14a';

/// See also [collectorBoardFuture].
@ProviderFor(collectorBoardFuture)
const collectorBoardFutureProvider = CollectorBoardFutureFamily();

/// See also [collectorBoardFuture].
class CollectorBoardFutureFamily extends Family<AsyncValue<Board?>> {
  /// See also [collectorBoardFuture].
  const CollectorBoardFutureFamily();

  /// See also [collectorBoardFuture].
  CollectorBoardFutureProvider call({
    required String collectorID,
  }) {
    return CollectorBoardFutureProvider(
      collectorID: collectorID,
    );
  }

  @override
  CollectorBoardFutureProvider getProviderOverride(
    covariant CollectorBoardFutureProvider provider,
  ) {
    return call(
      collectorID: provider.collectorID,
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
  String? get name => r'collectorBoardFutureProvider';
}

/// See also [collectorBoardFuture].
class CollectorBoardFutureProvider extends AutoDisposeFutureProvider<Board?> {
  /// See also [collectorBoardFuture].
  CollectorBoardFutureProvider({
    required String collectorID,
  }) : this._internal(
          (ref) => collectorBoardFuture(
            ref as CollectorBoardFutureRef,
            collectorID: collectorID,
          ),
          from: collectorBoardFutureProvider,
          name: r'collectorBoardFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$collectorBoardFutureHash,
          dependencies: CollectorBoardFutureFamily._dependencies,
          allTransitiveDependencies:
              CollectorBoardFutureFamily._allTransitiveDependencies,
          collectorID: collectorID,
        );

  CollectorBoardFutureProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.collectorID,
  }) : super.internal();

  final String collectorID;

  @override
  Override overrideWith(
    FutureOr<Board?> Function(CollectorBoardFutureRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CollectorBoardFutureProvider._internal(
        (ref) => create(ref as CollectorBoardFutureRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        collectorID: collectorID,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Board?> createElement() {
    return _CollectorBoardFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CollectorBoardFutureProvider &&
        other.collectorID == collectorID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, collectorID.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CollectorBoardFutureRef on AutoDisposeFutureProviderRef<Board?> {
  /// The parameter `collectorID` of this provider.
  String get collectorID;
}

class _CollectorBoardFutureProviderElement
    extends AutoDisposeFutureProviderElement<Board?>
    with CollectorBoardFutureRef {
  _CollectorBoardFutureProviderElement(super.provider);

  @override
  String get collectorID =>
      (origin as CollectorBoardFutureProvider).collectorID;
}

String _$boardStreamHash() => r'9f5209680e12746adc51c0c58b3ce5b924add2a8';

/// See also [boardStream].
@ProviderFor(boardStream)
const boardStreamProvider = BoardStreamFamily();

/// See also [boardStream].
class BoardStreamFamily extends Family<AsyncValue<Board?>> {
  /// See also [boardStream].
  const BoardStreamFamily();

  /// See also [boardStream].
  BoardStreamProvider call({
    required String boardID,
  }) {
    return BoardStreamProvider(
      boardID: boardID,
    );
  }

  @override
  BoardStreamProvider getProviderOverride(
    covariant BoardStreamProvider provider,
  ) {
    return call(
      boardID: provider.boardID,
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
  String? get name => r'boardStreamProvider';
}

/// See also [boardStream].
class BoardStreamProvider extends AutoDisposeStreamProvider<Board?> {
  /// See also [boardStream].
  BoardStreamProvider({
    required String boardID,
  }) : this._internal(
          (ref) => boardStream(
            ref as BoardStreamRef,
            boardID: boardID,
          ),
          from: boardStreamProvider,
          name: r'boardStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$boardStreamHash,
          dependencies: BoardStreamFamily._dependencies,
          allTransitiveDependencies:
              BoardStreamFamily._allTransitiveDependencies,
          boardID: boardID,
        );

  BoardStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.boardID,
  }) : super.internal();

  final String boardID;

  @override
  Override overrideWith(
    Stream<Board?> Function(BoardStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: BoardStreamProvider._internal(
        (ref) => create(ref as BoardStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        boardID: boardID,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Board?> createElement() {
    return _BoardStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BoardStreamProvider && other.boardID == boardID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, boardID.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin BoardStreamRef on AutoDisposeStreamProviderRef<Board?> {
  /// The parameter `boardID` of this provider.
  String get boardID;
}

class _BoardStreamProviderElement
    extends AutoDisposeStreamProviderElement<Board?> with BoardStreamRef {
  _BoardStreamProviderElement(super.provider);

  @override
  String get boardID => (origin as BoardStreamProvider).boardID;
}

String _$boardFutureHash() => r'3db75a724541bc99c7143e6267325e3f4be883c7';

/// See also [boardFuture].
@ProviderFor(boardFuture)
const boardFutureProvider = BoardFutureFamily();

/// See also [boardFuture].
class BoardFutureFamily extends Family<AsyncValue<Board?>> {
  /// See also [boardFuture].
  const BoardFutureFamily();

  /// See also [boardFuture].
  BoardFutureProvider call({
    required String boardID,
  }) {
    return BoardFutureProvider(
      boardID: boardID,
    );
  }

  @override
  BoardFutureProvider getProviderOverride(
    covariant BoardFutureProvider provider,
  ) {
    return call(
      boardID: provider.boardID,
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
  String? get name => r'boardFutureProvider';
}

/// See also [boardFuture].
class BoardFutureProvider extends AutoDisposeFutureProvider<Board?> {
  /// See also [boardFuture].
  BoardFutureProvider({
    required String boardID,
  }) : this._internal(
          (ref) => boardFuture(
            ref as BoardFutureRef,
            boardID: boardID,
          ),
          from: boardFutureProvider,
          name: r'boardFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$boardFutureHash,
          dependencies: BoardFutureFamily._dependencies,
          allTransitiveDependencies:
              BoardFutureFamily._allTransitiveDependencies,
          boardID: boardID,
        );

  BoardFutureProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.boardID,
  }) : super.internal();

  final String boardID;

  @override
  Override overrideWith(
    FutureOr<Board?> Function(BoardFutureRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: BoardFutureProvider._internal(
        (ref) => create(ref as BoardFutureRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        boardID: boardID,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Board?> createElement() {
    return _BoardFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BoardFutureProvider && other.boardID == boardID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, boardID.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin BoardFutureRef on AutoDisposeFutureProviderRef<Board?> {
  /// The parameter `boardID` of this provider.
  String get boardID;
}

class _BoardFutureProviderElement
    extends AutoDisposeFutureProviderElement<Board?> with BoardFutureRef {
  _BoardFutureProviderElement(super.provider);

  @override
  String get boardID => (origin as BoardFutureProvider).boardID;
}

String _$collectorsNotConnectedToABoardStreamHash() =>
    r'e2eafa67735ae23ca7b8e4e797261985805ed68f';

/// gets a list of all collectors that are not yet connected
/// to a [Board]
///
/// Copied from [collectorsNotConnectedToABoardStream].
@ProviderFor(collectorsNotConnectedToABoardStream)
final collectorsNotConnectedToABoardStreamProvider =
    AutoDisposeStreamProvider<List<Collector?>>.internal(
  collectorsNotConnectedToABoardStream,
  name: r'collectorsNotConnectedToABoardStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$collectorsNotConnectedToABoardStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CollectorsNotConnectedToABoardStreamRef
    = AutoDisposeStreamProviderRef<List<Collector?>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
