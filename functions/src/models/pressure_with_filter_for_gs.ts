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

  constructor(
    entityId: number,
    entityName: string,
    companyId: number,
    companyName: string,
    filterInPressure: number,
    filterOutPressure: number,
    filterDiffPressure: number,
    createdAt: string,
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

  getValues(): any[][] {
    return [Object.values(this)];
  }
}
