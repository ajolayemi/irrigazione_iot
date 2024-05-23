import {BaseData} from "../interfaces/gs_sheet_interfaces";

export class SectorStatusGs implements BaseData {
  entityId: number;
  entityName: string;
  companyId: number;
  companyName: string;
  collectorId: number;
  collectorName: string;
  status: boolean;
  createdAt: string;

  constructor(
    entityId: number,
    entityName: string,
    companyId: number,
    companyName: string,
    collectorId: number,
    collectorName: string,
    status: boolean,
    createdAt: string
  ) {
    this.entityId = entityId;
    this.entityName = entityName;
    this.companyId = companyId;
    this.companyName = companyName;
    this.collectorId = collectorId;
    this.collectorName = collectorName;
    this.status = status;
    this.createdAt = createdAt;
  }

  getValues(): any[][] {
    return [Object.values(this)];
  }
}
