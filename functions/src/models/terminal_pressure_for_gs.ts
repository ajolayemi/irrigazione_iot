import {BaseData} from "../interfaces/gs_sheet_interfaces";

/**
 * Model class for terminal pressure data inserted into google sheets
 */
export class TerminalPressureForGs implements BaseData {
  entityId: number;
  entityName: string;
  companyId: number;
  companyName: string;
  pressure: number;
  createdAt: string;

  /**
   * Creates a new instance of the TerminalPressureForGs class
   * @param {number} entityId The id of this terminal
   * @param {string} entityName The name of this terminal
   * @param {number} companyId The id of the company this terminal belongs to
   * @param {string} companyName The name of the company this terminal belongs to
   * @param {number} pressure The pressure of this terminal
   * @param {string} createdAt The timestamp of when this terminal pressure data was received
   */
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

  /**
   * Retrieves the values of the current instance as a 2D array.
   * @return {Array<Array>} The values of the current instance as a 2D array.
   */
  getValues(): any[][] {
    return [Object.values(this)];
  }
}
