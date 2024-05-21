import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_sectors_id_provider.g.dart';

/// A notifier class that holds the list of ids of
///
/// the [Sector]s selected to be connected to a [Collector]
///
@Riverpod(keepAlive: true)
class SelectedSectorsId extends _$SelectedSectorsId {
  @override
  List<String?> build() => [];

  void initState(List<String> ids) => state = ids;

  void add(String id) => state = [...state, id];

  void removeAtIndex(String id, int index) {
    final newState = [...state];
    newState.removeAt(index);
    state = newState;
  }

  void clear() => state = [];
}
