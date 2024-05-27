import {TablesInsert} from "../../../schemas/database.types";
import {PressureProcessingData} from "../../interfaces/interfaces";
import {PressureWithFilterGs} from "../../models/pressure_with_filter_for_gs";
import {SectorPressureGs} from "../../models/sector_pressure_for_gs";
import {TerminalPressureForGs} from "../../models/terminal_pressure_for_gs";
import {insertDataInSheet} from "../../utils/gs_utils";
import {customFormatDate} from "../../utils/helper_funcs";
import {getCollectorById} from "../collectors/read_collector_data";
import {getCompanyById} from "../companies/read_company_data";
import {
  getCollectorBySectorId,
  getSectorById,
} from "../sectors/read_sector_data";

/**
 * Processes collector pressure data for google sheet
 * @param {TablesInsert<"collector_pressures">} data The collector pressure data to process
 * @return {Promise<boolean>} A promise that resolves to true if the collector pressure data
 */
export const processCollectorPressureDataForGs = async (
  data: TablesInsert<"collector_pressures">
): Promise<boolean> => {
  if (!data) {
    throw new Error(
      "No data provided to process collector pressure data for google sheet"
    );
  }
  console.log(
    "Processing collector pressure data for google sheet with data: "
  );
  console.log(data);
  try {
    // Get the necessary data
    const {collector, company} = await getPressureProcessingData(
      data.collector_id.toString()
    );

    const toDate = new Date(data.created_at ?? new Date());

    // Prepare and insert data to google sheet
    // Save to google sheets
    const dataForGs = new PressureWithFilterGs(
      collector.id,
      collector.name,
      company.id,
      company.name,
      data.filter_in_pressure ?? 0,
      data.filter_out_pressure ?? 0,
      data.pressure_difference ?? 0,
      customFormatDate(toDate)
    );

    await insertDataInSheet("collector_pressures", dataForGs.getValues());
    return Promise.resolve(true);
  } catch (error) {
    throw new Error(
      `Error processing collector pressure data for google sheet: ${error}`
    );
  }
};

/**
 * Processes sector pressure data for google sheet
 * @param {TablesInsert<"sector_pressures">} data The sector pressure data to process
 * @return {Promise<boolean>} A promise that resolves to true if the sector pressure data
 */
export const processSectorPressureDataForGs = async (
  data: TablesInsert<"sector_pressures">
): Promise<boolean> => {
  if (!data) {
    throw new Error(
      "No data provided to process sector pressure data for google sheet"
    );
  }
  console.log("Processing sector pressure data for google sheet with data: ");
  console.log(data);
  try {
    // Get the collectorSector object this sector is associated with
    const collectorSector = await getCollectorBySectorId(
      data.sector_id.toString()
    );

    const {collector, company} = await getPressureProcessingData(
      collectorSector.collector_id.toString()
    );

    // Get the sector this status belongs to
    const sector = await getSectorById(data.sector_id.toString());

    const toDate = new Date(data.created_at ?? new Date());

    const dataForGs = new SectorPressureGs(
      sector.id,
      sector.name,
      sector.company_id,
      company.name,
      collector.id,
      collector.name,
      data.pressure ?? 0,
      customFormatDate(toDate)
    );

    await insertDataInSheet("sector_pressures", dataForGs.getValues());
    return Promise.resolve(true);
  } catch (error) {
    throw new Error(
      `Error processing sector pressure data for google sheet: ${error}`
    );
  }
};

/**
 * Processes terminal pressure data for google sheet
 * @param {TablesInsert<"terminal_pressures">} data The terminal pressure data to process
 * @return {Promise<boolean>} A promise that resolves to true if the terminal pressure data
 */
export const processTerminalPressureDataForGs = async (
  data: TablesInsert<"terminal_pressures">
): Promise<boolean> => {
  if (!data) {
    throw new Error(
      "No data provided to process terminal pressure data for google sheet"
    );
  }
  console.log("Processing terminal pressure data for google sheet with data: ");
  console.log(data);

  try {
    const {collector, company} = await getPressureProcessingData(
      data.collector_id.toString()
    );
    const toDate = new Date(data.created_at ?? new Date());

    // Prepare and insert data to google sheet
    const dataForGs = new TerminalPressureForGs(
      collector.id,
      collector.name,
      company.id,
      company.name,
      data.pressure ?? 0,
      customFormatDate(toDate)
    );

    await insertDataInSheet("terminal_pressures", dataForGs.getValues());
    return Promise.resolve(true);
  } catch (error) {
    throw new Error(
      `Error processing terminal pressure data for google sheet: ${error}`
    );
  }
};

/**
 * Filters out data required to process various pressure messages
 * @param {string}  collectorId Base collector of the sector or collector
 * that this pressure message belongs to
 * @return {Promise<PressureProcessingData>} The collector and company object data
 */
export const getPressureProcessingData = async (
  collectorId: string
): Promise<PressureProcessingData> => {
  try {
    // Get the collector this terminal pressure data belongs to
    const collector = await getCollectorById(collectorId);

    if (!collector) {
      throw new Error(
        `No collector found for the collector with id: ${collectorId}`
      );
    }

    // Get the company this collector belongs to
    const company = await getCompanyById(collector.company_id.toString());

    if (!company) {
      throw new Error(
        `No company found for the company with id: ${collector.company_id}`
      );
    }

    return Promise.resolve({
      collector,
      company,
    });
  } catch (error) {
    throw new Error(`Error getting pressure processing data: ${error}`);
  }
};
