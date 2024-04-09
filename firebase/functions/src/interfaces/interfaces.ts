/**
 * An interface that defines the keys that are expected in a pressure message
 * sent from the MQTT broker
 */
export interface PressureMessageKeys {
  terminalPressureKey: string;
  collectorPressureKeys: string[];
  sectorKeys: string[];
}
