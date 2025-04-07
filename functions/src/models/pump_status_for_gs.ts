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

  /**
   * Creates a new instance of the StatusGs class
   * @param {number} entityId The id of this entity (pump, sector, ...)
   * @param {string} entityName The name of this entity
   * @param {number} companyId The id of the company this entity belongs to
   * @param {string} companyName The name of the company this entity belongs to
   * @param {boolean} status The status of this entity
   * @param {string} createdAt The timestamp of when this status data was received
   */
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

  /**
   * Retrieves the values of the current instance as a 2D array.
   * @return {Array<Array>} The values of the current instance as a 2D array.
   */
  getValues(): any[][] {
    return [Object.values(this)];
  }
}
