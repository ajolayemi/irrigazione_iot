/**
 * An interface that defines the keys that are expected in a pressure message
 * sent from the MQTT broker
 */
export interface PressureMessageKeys {
  terminalPressureKey: string;
  collectorPressureKeys: string[];
  sectorKeys: string[];
  splittedSectorKeys: string[];
}

export interface CustomJSON {
  [key: string]: any;
}

/**
 * An interface of what the sector status msg from MQTT - Dataflow - PubSub looks like
 */
export interface SectorStatusMessage {
  status: string;
  mqttMsgName: string;
}
