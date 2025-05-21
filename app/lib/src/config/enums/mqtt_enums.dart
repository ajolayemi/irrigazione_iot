enum MqttMessageTypes {
  pumpStatus('pump_status'),
  sectorStatus('sector_status');

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
