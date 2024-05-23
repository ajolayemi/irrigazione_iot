import {BaseStatusSheetData} from "../interfaces/gs_sheet_interfaces";

/**
 * Model class for pump statuses data inserted into google sheets
 */
export class StatusGs implements BaseStatusSheetData {
  entityId: number;
  entityName: string;
  companyId: number;
  companyName: string;
  status: boolean;
  createdAt: string;

  constructor(
    entityId: number,
    entityName: string,
    companyId: number,
    companyName: string,
    status: boolean,
    createdAt: string
  ) {
    this.entityId = entityId;
    this.entityName = entityName;
    this.companyId = companyId;
    this.companyName = companyName;
    this.status = status;
    this.createdAt = createdAt;
  }

  getValues(): any[][] {
    return [Object.values(this)];
  }
}
