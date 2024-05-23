import {BaseData} from "../interfaces/gs_sheet_interfaces";

export class TerminalPressureForGs implements BaseData {
  entityId: number;
  entityName: string;
  companyId: number;
  companyName: string;
  pressure: number;
  createdAt: string;

  constructor(
    entityId: number,
    entityName: string,
    companyId: number,
    companyName: string,
    pressure: number,
    createdAt: string
  ) {
    this.entityId = entityId;
    this.entityName = entityName;
    this.companyId = companyId;
    this.companyName = companyName;
    this.pressure = pressure;
    this.createdAt = createdAt;
  }

  getValues(): any[][] {
    return [Object.values(this)];
  }
}
