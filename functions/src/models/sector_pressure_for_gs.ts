import {BaseData} from "../interfaces/gs_sheet_interfaces";

/**
 * Model class for sector pressure data inserted into google sheets
 */
export class SectorPressureGs implements BaseData {
  entityId: number;
  entityName: string;
  companyId: number;
  companyName: string;
  collectorId: number;
  collectorName: string;
  pressure: number;
  createdAt: string;

  constructor(
    entityId: number,
    entityName: string,
    companyId: number,
    companyName: string,
    collectorId: number,
    collectorName: string,
    pressure: number,
    createdAt: string
  ) {
    this.entityId = entityId;
    this.entityName = entityName;
    this.companyId = companyId;
    this.companyName = companyName;
    this.collectorId = collectorId;
    this.collectorName = collectorName;
    this.pressure = pressure;
    this.createdAt = createdAt;
  }

  getValues(): any[][] {
    return [Object.values(this)];
  }
}
