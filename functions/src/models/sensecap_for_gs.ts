import {BaseData} from "../interfaces/gs_sheet_interfaces";

/**
 * Model class for sensecap data inserted into google sheets
 */
export class SenseCapGs implements BaseData {
  entityId: number;
  entityName: string;
  euiStazione: string;
  companyId: number;
  companyName: string;
  sectorId: number;
  sectorName: string;
  airTemperature: number;
  airHumidity: number;
  lightIntensity: number;
  uvIndex: number;
  windSpeed: number;
  rainGauge: number;
  barometricPressure: number;
  windDirectionSensor: number;
  createdAt: string;

  /**
   * Creates a new instance of the SenseCapGs class
   * @param {number} entityId The id of this weather station
   * @param {string} entityName The name of this weather station
   * @param {string} euiStazione The EUI of this weather station
   * @param {number} companyId The id of the company this weather station belongs to
   * @param {string} companyName The name of the company this weather station belongs to
   * @param {number} sectorId The id of the sector this weather station belongs to
   * @param {string} sectorName The name of the sector this weather station belongs to
   * @param {number} airTemperature The air temperature of this weather station
   * @param {number} airHumidity The air humidity of this weather station
   * @param {number} lightIntensity The light intensity of this weather station
   * @param {number} uvIndex The UV index of this weather station
   * @param {number} windSpeed The wind speed of this weather station
   * @param {number} rainGauge The rain gauge of this weather station
   * @param {number} barometricPressure The barometric pressure of this weather station
   * @param {number} windDirectionSensor The wind direction sensor of this weather station
   * @param {string} createdAt The timestamp of when this sensecap data was received
   *
   */
  constructor(
    entityId: number,
    entityName: string,
    euiStazione: string,
    companyId: number,
    companyName: string,
    sectorId: number,
    sectorName: string,
    airTemperature: number,
    airHumidity: number,
    lightIntensity: number,
    uvIndex: number,
    windSpeed: number,
    rainGauge: number,
    barometricPressure: number,
    windDirectionSensor: number,
    createdAt: string
  ) {
    this.entityId = entityId;
    this.entityName = entityName;
    this.euiStazione = euiStazione;
    this.companyId = companyId;
    this.companyName = companyName;
    this.sectorId = sectorId;
    this.sectorName = sectorName;
    this.airTemperature = airTemperature;
    this.airHumidity = airHumidity;
    this.lightIntensity = lightIntensity;
    this.uvIndex = uvIndex;
    this.windSpeed = windSpeed;
    this.rainGauge = rainGauge;
    this.barometricPressure = barometricPressure;
    this.windDirectionSensor = windDirectionSensor;
    this.createdAt = createdAt;
  }

  /**
   * Retrieves the values of the current instance as a 2D array.
   * @return {Array<Array>} The values of the current instance as a 2D array.
   */
  getValues(): any[][] {
    return [Object.values(this)];
  }
}

/**
 * Model class for sensecap battery data inserted into google sheets
 */
export class SenseCapBatteryGs implements BaseData {
  entityId: number;
  entityName: string;
  euiStazione: string;
  companyId: number;
  companyName: string;
  sectorId: number;
  sectorName: string;
  batteryLevel: number;
  createdAt: string;

  /**
   * Creates a new instance of the SenseCapBatteryGs class
   * @param {number} entityId The id of this weather station
   * @param {string} entityName The name of this weather station
   * @param {string} euiStazione The EUI of this weather station
   * @param {number} companyId The id of the company this weather station belongs to
   * @param {string} companyName The name of the company this weather station belongs to
   * @param {number} sectorId The id of the sector this weather station belongs to
   * @param {string} sectorName The name of the sector this weather station belongs to
   * @param {number} batteryLevel The battery level of this weather station
   * @param {string} createdAt The timestamp of when this sensecap battery data was received
   */
  constructor(
    entityId: number,
    entityName: string,
    euiStazione: string,
    companyId: number,
    companyName: string,
    sectorId: number,
    sectorName: string,
    batteryLevel: number,
    createdAt: string
  ) {
    this.entityId = entityId;
    this.entityName = entityName;
    this.euiStazione = euiStazione;
    this.companyId = companyId;
    this.companyName = companyName;
    this.sectorId = sectorId;
    this.sectorName = sectorName;
    this.batteryLevel = batteryLevel;
    this.createdAt = createdAt;
  }

  /**
   * Retrieves the values of the current instance as a 2D array.
   * @return {Array<Array>} The values of the current instance as a 2D array.
   */
  getValues(): any[][] {
    return [Object.values(this)];
  }
}
