/// A standard class for path parameters passed in when navigating to a new screen.
class PathParameters {
  const PathParameters({required this.id});

  /// Values like sectorId, sensorId, sectorId and so on are the most
  /// passed on values when navigating to a new screen.
  final String id;

  Map<String, String> toJson() {
    return <String, String>{
      'id': id,
    };
  }

  factory PathParameters.fromJson(Map<String, dynamic> map) {
    return PathParameters(
      id: map['id'] as String,
    );
  }
}
