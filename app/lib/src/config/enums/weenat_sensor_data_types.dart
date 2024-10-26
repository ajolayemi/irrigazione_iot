enum WeenatSensorDataType {
  temperature(id: 1),
  waterPotential(id: 2);

  final int id;

  const WeenatSensorDataType({required this.id});
}

enum WeenatDataRangeType {
  lastHour,
  yesterday,
  last7Days,
}
