// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_status_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$boardStatusRepositoryHash() =>
    r'eb256ef62070a71cc1bf3cce3f0513b5477203b6';

/// See also [boardStatusRepository].
@ProviderFor(boardStatusRepository)
final boardStatusRepositoryProvider = Provider<BoardStatusRepository>.internal(
  boardStatusRepository,
  name: r'boardStatusRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$boardStatusRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef BoardStatusRepositoryRef = ProviderRef<BoardStatusRepository>;
String _$boardStatusStreamHash() => r'5689c948b59ec68c994573e09aec6f7574a2d3db';

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

/// See also [boardStatusStream].
@ProviderFor(boardStatusStream)
const boardStatusStreamProvider = BoardStatusStreamFamily();

/// See also [boardStatusStream].
class BoardStatusStreamFamily extends Family<AsyncValue<BoardStatus?>> {
  /// See also [boardStatusStream].
  const BoardStatusStreamFamily();

  /// See also [boardStatusStream].
  BoardStatusStreamProvider call({
    required String boardID,
  }) {
    return BoardStatusStreamProvider(
      boardID: boardID,
    );
  }

  @override
  BoardStatusStreamProvider getProviderOverride(
    covariant BoardStatusStreamProvider provider,
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
  String? get name => r'boardStatusStreamProvider';
}

/// See also [boardStatusStream].
class BoardStatusStreamProvider
    extends AutoDisposeStreamProvider<BoardStatus?> {
  /// See also [boardStatusStream].
  BoardStatusStreamProvider({
    required String boardID,
  }) : this._internal(
          (ref) => boardStatusStream(
            ref as BoardStatusStreamRef,
            boardID: boardID,
          ),
          from: boardStatusStreamProvider,
          name: r'boardStatusStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$boardStatusStreamHash,
          dependencies: BoardStatusStreamFamily._dependencies,
          allTransitiveDependencies:
              BoardStatusStreamFamily._allTransitiveDependencies,
          boardID: boardID,
        );

  BoardStatusStreamProvider._internal(
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
    Stream<BoardStatus?> Function(BoardStatusStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: BoardStatusStreamProvider._internal(
        (ref) => create(ref as BoardStatusStreamRef),
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
  AutoDisposeStreamProviderElement<BoardStatus?> createElement() {
    return _BoardStatusStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BoardStatusStreamProvider && other.boardID == boardID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, boardID.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin BoardStatusStreamRef on AutoDisposeStreamProviderRef<BoardStatus?> {
  /// The parameter `boardID` of this provider.
  String get boardID;
}

class _BoardStatusStreamProviderElement
    extends AutoDisposeStreamProviderElement<BoardStatus?>
    with BoardStatusStreamRef {
  _BoardStatusStreamProviderElement(super.provider);

  @override
  String get boardID => (origin as BoardStatusStreamProvider).boardID;
}

String _$boardStatusFutureHash() => r'6ebb5d8187d796f61d3636540f6b947be51d3207';

/// See also [boardStatusFuture].
@ProviderFor(boardStatusFuture)
const boardStatusFutureProvider = BoardStatusFutureFamily();

/// See also [boardStatusFuture].
class BoardStatusFutureFamily extends Family<AsyncValue<BoardStatus?>> {
  /// See also [boardStatusFuture].
  const BoardStatusFutureFamily();

  /// See also [boardStatusFuture].
  BoardStatusFutureProvider call({
    required String boardID,
  }) {
    return BoardStatusFutureProvider(
      boardID: boardID,
    );
  }

  @override
  BoardStatusFutureProvider getProviderOverride(
    covariant BoardStatusFutureProvider provider,
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
  String? get name => r'boardStatusFutureProvider';
}

/// See also [boardStatusFuture].
class BoardStatusFutureProvider
    extends AutoDisposeFutureProvider<BoardStatus?> {
  /// See also [boardStatusFuture].
  BoardStatusFutureProvider({
    required String boardID,
  }) : this._internal(
          (ref) => boardStatusFuture(
            ref as BoardStatusFutureRef,
            boardID: boardID,
          ),
          from: boardStatusFutureProvider,
          name: r'boardStatusFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$boardStatusFutureHash,
          dependencies: BoardStatusFutureFamily._dependencies,
          allTransitiveDependencies:
              BoardStatusFutureFamily._allTransitiveDependencies,
          boardID: boardID,
        );

  BoardStatusFutureProvider._internal(
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
    FutureOr<BoardStatus?> Function(BoardStatusFutureRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: BoardStatusFutureProvider._internal(
        (ref) => create(ref as BoardStatusFutureRef),
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
  AutoDisposeFutureProviderElement<BoardStatus?> createElement() {
    return _BoardStatusFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BoardStatusFutureProvider && other.boardID == boardID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, boardID.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin BoardStatusFutureRef on AutoDisposeFutureProviderRef<BoardStatus?> {
  /// The parameter `boardID` of this provider.
  String get boardID;
}

class _BoardStatusFutureProviderElement
    extends AutoDisposeFutureProviderElement<BoardStatus?>
    with BoardStatusFutureRef {
  _BoardStatusFutureProviderElement(super.provider);

  @override
  String get boardID => (origin as BoardStatusFutureProvider).boardID;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
