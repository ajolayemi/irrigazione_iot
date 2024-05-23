import {BoardStatusSheetData} from "../interfaces/gs_sheet_interfaces";

/**
 * A model class for the board status data passed
 * to google sheets
 */
export class BoardStatusGs implements BoardStatusSheetData {
  workSheetName: string;
  entityId: number;
  entityName: string;
  companyId: number;
  companyName: string;
  batteryLevel: number;
  createdAt: string;

  constructor(
    entityId: number,
    entityName: string,
    companyId: number,
    companyName: string,
    batteryLevel: number,
    createdAt: string
  ) {
    this.entityId = entityId;
    this.entityName = entityName;
    this.companyId = companyId;
    this.companyName = companyName;
    this.batteryLevel = batteryLevel;
    this.createdAt = createdAt;
    this.workSheetName = "board_statuses";
  }

  getValues(): any[][] {
    return [Object.values(this)];
  }
}
