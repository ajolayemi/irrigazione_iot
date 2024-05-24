/**
 * An interface that defines the keys that are expected in a pressure message
 * sent from the MQTT broker
 */
export interface PressureMessageKeys {
  /**
   * The key identifying the terminal pressure just as it is in the received mqtt message
   */
  terminalPressureKey: string;
  /**
   * A list of keys identifying the collector pressures just as they are in the received mqtt message
   *
   */
  collectorPressureKeys: string[];
  /**
   * A list keys identifying the sectors just as they are in the received mqtt message
   * @example ["A_CH1", "ME8_CH2"] where the characters before the underscore
   * are the sector names
   */
  sectorKeys: string[];
  /**
   * A list of processed keys identifying the sectors from the mqtt message
   * @example ["A", "ME8"] where the characters before the underscore
   * are the sector names
   */
  splittedSectorKeys: string[];
}

export interface CustomJSON {
  [key: string]: any;
}

/**
 * An interface of what the status msgs from MQTT - Dataflow - PubSub looks like
 */
export interface StatusMessage {
  status: string;
  name: string;
  type: string;
}

/**
 * An interface of what pump flow rate message from MQTT - Dataflow - PubSub looks like
 */
export interface PumpFlowRateMessage {
  count: number;
  name: string;
  litresPerSecond: number;
}

export interface PumpPressureKeys {
  nameKey: string;
  filterInKey: string;
  filterOutKey: string;
}

export interface BoardStatusMessage {
  vbat: number;
  eui: string;
}


export interface WeatherStationMeasurementData {
  measurementId: string;
  measurementValue: number;
  type: string;
}

export interface WeatherStationBatteryData {
  "Battery(%)": number;
}
export interface SenseCapSensorData {
  receivedAt: string;
  valid: boolean;
  deviceEui: string;
  measurements: WeatherStationMeasurementData[];
  battery?: WeatherStationBatteryData;
}
