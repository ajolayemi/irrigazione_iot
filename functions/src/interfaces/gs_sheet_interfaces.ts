/**
 * A base SQL table like relation / data interface for different
 * entities in the database whose data can and will be inserted
 * into google sheets
 */
export interface BaseData {
  /**
   * The id of the entity, for example the id of a board
   * a pump and so on
   */
  entityId: number;

  /**
   * The name of the entity, for example the name of a board
   * a pump and so on
   */
  entityName: string;

  /**
   * The id of the company the entity belongs to
   */
  companyId: number;

  /**
   * The name of the company the entity belongs to
   */
  companyName: string;

  /**
   * The date the data was created
   */
  createdAt: string;

  /**
   * A base function to get the values of the entity
   * for insertion into google sheets
   */
  getValues(): any[][];
}

/**
 * Interface for board status data inserted in google sheets
 */
export interface BoardStatusSheetData extends BaseData {
  /**
   * The battery level of the board
   */
  batteryLevel: number;
}

/**
 * Interface for collector pressures data inserted in google sheets
 */