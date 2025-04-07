import {PressureWithFilterSheetData} from "../interfaces/gs_sheet_interfaces";

/**
 * Model class for pressure data inserted into google sheets
 * Mostly used for pump and collector pressure
 */
export class PressureWithFilterGs implements PressureWithFilterSheetData {
  entityId: number;
  entityName: string;
  companyId: number;
  companyName: string;
  filterInPressure: number;
  filterOutPressure: number;
  filterDiffPressure: number;
  createdAt: string;

  /**
   * Creates a new instance of the PressureWithFilterGs class
   * @param {number} entityId The id of the entity
   *  @param {string} entityName The name of the entity
   * @param {number} companyId The id of the company this entity belongs to
   * @param {string} companyName The name of the company this entity belongs to
   * @param {number} filterInPressure The pressure of the "filtro in ingresso"
   * @param {number} filterOutPressure The pressure of the "filtro in uscita"
   * @param {number} filterDiffPressure The pressure difference between the two filters
   * @param {string} createdAt The timestamp of when this pressure data was received
   * */
  constructor(
    entityId: number,
    entityName: string,
    companyId: number,
    companyName: string,
    filterInPressure: number,
    filterOutPressure: number,
    filterDiffPressure: number,
    createdAt: string
  ) {
    this.entityId = entityId;
    this.entityName = entityName;
    this.companyId = companyId;
    this.companyName = companyName;
    this.filterInPressure = filterInPressure;
    this.filterOutPressure = filterOutPressure;
    this.filterDiffPressure = filterDiffPressure;
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
