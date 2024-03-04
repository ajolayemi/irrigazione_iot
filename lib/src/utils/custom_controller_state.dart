// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

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
