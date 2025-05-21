enum MqttMessageTypes {
  pumpStatus('pump_status'),
  sectorStatus('sector_status'),
  pumpFlow('pump_flow'),
  pumpPressure('pump_pressure'),
  collectorPressure('collector_pressure'),
  sectorPressure('sector_pressure'),
  terminalPressure('terminal_pressure');

  final String type;
  const MqttMessageTypes(this.type);
}

extension MqttMsgTypesExt on MqttMessageTypes {
  bool get isPumpStatus {
    return this == MqttMessageTypes.pumpStatus;
  }

  bool get isSectorStatus {
    return this == MqttMessageTypes.sectorStatus;
  }
}
