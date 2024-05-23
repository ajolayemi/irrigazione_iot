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

  getValues(): any[][] {
    return [Object.values(this)];
  }
}
