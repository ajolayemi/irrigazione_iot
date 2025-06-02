enum AppMqttMessageTypes {
  pumpStatus('pump_status'),
  sectorStatus('sector_status'),
  pumpFlow('pump_flow'),
  pumpPressure('pump_pressure'),
  /// Stands for sector_pressure, collector_pressure and terminal_pressure
  /// as they all are contained in single mqtt msg
  pressure('pressure');

  final String type;
  const AppMqttMessageTypes(this.type);
}

extension MqttMsgTypesExt on AppMqttMessageTypes {
  bool get isPumpStatus {
    return this == AppMqttMessageTypes.pumpStatus;
  }

  bool get isSectorStatus {
    return this == AppMqttMessageTypes.sectorStatus;
  }
}
