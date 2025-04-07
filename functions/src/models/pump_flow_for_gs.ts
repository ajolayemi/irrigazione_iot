import {PumpFlowSheetData} from "../interfaces/gs_sheet_interfaces";

/**
 * Model class for pump flow data inserted into google sheets
 */
export class PumpFlowGs implements PumpFlowSheetData {
  entityId: number;
  entityName: string;
  companyId: number;
  companyName: string;
  flow: number;
  dispensedLitresPerSecond: number;
  createdAt: string;

  /**
   * Creates a new instance of the PumpFlowGs class
   * @param {number} entityId The id of this pump
   * @param {string} entityName The name of this pump
   * @param {number} companyId The id of the company this pump belongs to
   * @param {string} companyName The name of the company this pump belongs to
   * @param {number} flow The flow of this pump
   * @param {number} dispensedLitresPerSecond The amount of litres dispensed per second
   * @param {string} createdAt The timestamp of when this pump flow data was received
   */
  constructor(
    entityId: number,
    entityName: string,
    companyId: number,
    companyName: string,
    flow: number,
    dispensedLitresPerSecond: number,
    createdAt: string
  ) {
    this.entityId = entityId;
    this.entityName = entityName;
    this.companyId = companyId;
    this.companyName = companyName;
    this.flow = flow;
    this.dispensedLitresPerSecond = dispensedLitresPerSecond;
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
