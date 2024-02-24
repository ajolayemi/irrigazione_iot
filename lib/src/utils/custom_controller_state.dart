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
}