import {BoardStatusSheetData} from "../interfaces/gs_sheet_interfaces";

/**
 * A model class for the board status data passed
 * to google sheets
 */
export class BoardStatusGs implements BoardStatusSheetData {
  static readonly workSheetName = "board_statuses";
  entityId: number;
  entityName: string;
  companyId: number;
  companyName: string;
  batteryLevel: number;
  createdAt: string;

  /**
   * Creates a new instance of the BoardStatusGs class
   * @param {number} entityId The id of this board
   * @param {string} entityName  The name of this board
   * @param {number} companyId The id of the company this board belongs to
   * @param {string} companyName The name of the company this board belongs to
   * @param {number} batteryLevel The battery level of this board
   * @param {string} createdAt The timestamp of when this board status was received
   */
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
  }

  /**
   * @return {Array<Array>} The values of the current instance as a 2D array.
   */
  getValues(): any[][] {
    return [Object.values(this)];
  }
}
