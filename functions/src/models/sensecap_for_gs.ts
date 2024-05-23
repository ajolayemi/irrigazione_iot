import {BaseData} from "../interfaces/gs_sheet_interfaces";

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

  getValues(): any[][] {
    return [Object.values(this)];
  }
}

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

  getValues(): any[][] {
    return [Object.values(this)];
  }
}
