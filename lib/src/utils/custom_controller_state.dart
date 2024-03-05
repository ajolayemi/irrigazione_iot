// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomControllerState {
  const CustomControllerState({required this.loadingStates});

  final Map<String, bool> loadingStates;

  bool stateWithIdIsLoading(String stateId) => loadingStates[stateId] ?? false;

  // Checks if one of the loading states is true
  bool get isLoading  => loadingStates.values.any((element) => element);

  // Helper methods to manipulate the loading states
  CustomControllerState setLoading(String stateId, bool isLoading) {
    return CustomControllerState(
      loadingStates: Map.from(loadingStates)..[stateId] = isLoading,
    );
  }

  @override
  String toString() => 'CustomControllerState(loadingStates: $loadingStates)';

  @override
  bool operator ==(covariant CustomControllerState other) {
    if (identical(this, other)) return true;
  
    return 
      mapEquals(other.loadingStates, loadingStates);
  }

  @override
  int get hashCode => loadingStates.hashCode;
}


extension CustomAsyncControllerStateX on AsyncValue<CustomControllerState> {

  /// Returns true if the state with the given id is loading and the underline
  /// AsyncValue state has no error
  bool stateWithIdIsLoading(String stateId) {
    final currentStateIsLoading = value?.stateWithIdIsLoading(stateId) ?? false;
    return currentStateIsLoading && !hasError;
  }

  bool get isGlobalLoading => value?.isLoading ?? false;
}
