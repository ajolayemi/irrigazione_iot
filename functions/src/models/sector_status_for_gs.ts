import {BaseData} from "../interfaces/gs_sheet_interfaces";

/**
 * Model class for sector status data inserted into google sheets
 */
export class SectorStatusGs implements BaseData {
  entityId: number;
  entityName: string;
  companyId: number;
  companyName: string;
  collectorId: number;
  collectorName: string;
  status: boolean;
  createdAt: string;

  /**
   * Creates a new instance of the SectorStatusGs class
   * @param {number} entityId The id of this sector
   * @param {string} entityName The name of this sector
   * @param {number} companyId The id of the company this sector belongs to
   * @param {string} companyName The name of the company this sector belongs to
   * @param {number} collectorId The id of the collector this sector belongs to
   * @param {string} collectorName The name of the collector this sector belongs to
   * @param {boolean} status The status of this sector
   * @param {string} createdAt The timestamp of when this sector status data was received
   */
  constructor(
    entityId: number,
    entityName: string,
    companyId: number,
    companyName: string,
    collectorId: number,
    collectorName: string,
    status: boolean,
    createdAt: string
  ) {
    this.entityId = entityId;
    this.entityName = entityName;
    this.companyId = companyId;
    this.companyName = companyName;
    this.collectorId = collectorId;
    this.collectorName = collectorName;
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
