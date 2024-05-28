import {logger} from "firebase-functions/v2";
import {StatusMessage} from "../../interfaces/interfaces";
import {
  getCollectorBySectorId,
  getSectorById,
  getSectorByMqttMsgName,
} from "./read_sector_data";
import {TablesInsert} from "../../../schemas/database.types";
import {insertSectorStatus} from "./insert_sector_data";
import {getCompanyById} from "../companies/read_company_data";
import {getCollectorById} from "../collectors/read_collector_data";
import {SectorStatusGs} from "../../models/sector_status_for_gs";
import {customFormatDate} from "../../utils/helper_funcs";
import {insertDataInSheet} from "../../utils/gs_utils";

/**
 * Abstracts off the process of sector status message coming from
 * MQTT - Dataflow - PubSub. It basically process the message and insert
 * the sector status into the database
 * @param {StatusMessage} message The sector status message to process
 * @return {Promise<boolean>} A promise that resolves to true if the sector
 * status message was processed successfully, otherwise false
 */
export const processSectorStatusMessage = async (
  message: StatusMessage
): Promise<boolean> => {
  try {
    if (!message) {
      throw new Error("Message to process sector status is undefined");
    }

    logger.info(`Processing sector status message for ${message.name}`);
    const sectorName = message.name;
    const status = message.status;

    // get the sector by the provided name (mqtt-msg-name column in database)
    const sector = await getSectorByMqttMsgName(sectorName);

    if (!sector) {
      throw new Error(
        `No sector matching the provided ${sectorName} was found in database`
      );
    }

    // A check to ensure that the provided status matches either the sector's turn_on_command
    // or turn_off_command

    if (
      status !== sector.turn_on_command &&
      status !== sector.turn_off_command
    ) {
      throw new Error(
        `The provided status ${status} does not match the sector's turn_on_command or turn_off_command`
      );
    }

    const currentDate = new Date();

    // insert the sector status into the database
    // this is the status of the sector's pump
    const sectorStatus: TablesInsert<"sector_statuses"> = {
      status_boolean: sector.turn_on_command === status,
      created_at: currentDate.toISOString(),
      sector_id: sector.id,
      status,
    };

    logger.info(`Inserting sector status for ${sectorName} into database`);
    // Insert data to the database
    await insertSectorStatus(sectorStatus);

    logger.info(`Sector status for ${sectorName} inserted successfully`);
    return Promise.resolve(true);
  } catch (error) {
    throw new Error(`Error processing sector status message: ${error}`);
  }
};

/**
 * Processes sector status message for google sheet
 * @param {TablesInsert<"sector_statuses">} data The sector status to process
 * @return {Promise<boolean?>} A promise that resolves to true if the sector status
 * message was processed successfully, otherwise false
 */
export const processSectorStatusMessageForGs = async (
  data: TablesInsert<"sector_statuses">
): Promise<boolean> => {
  console.log("Processing sector status message for google sheet with data: ");
  console.log(data);
  if (!data) {
    throw new Error(
      "No data provided to process sector status message for google sheet"
    );
  }
  try {
    // Get the sector this status belongs to
    const sector = await getSectorById(data.sector_id.toString());

    // Get the company this sector belongs to
    const company = await getCompanyById(sector.company_id.toString());

    if (!company) {
      throw new Error(
        `No company found for the company with id: ${sector.company_id}`
      );
    }

    // Get the id of the collector this sector belongs to
    const collectorSector = await getCollectorBySectorId(sector.id.toString());

    if (!collectorSector) {
      throw new Error(
        `No collector found for the sector with id: ${sector.id}`
      );
    }

    // Get the collector details
    const collector = await getCollectorById(collectorSector.id.toString());

    const dataForGs = new SectorStatusGs(
      sector.id,
      sector.name,
      sector.company_id,
      company.name,
      collectorSector.id,
      collector.name,
      data.status_boolean ?? false,
      customFormatDate(data.created_at)
    );

    console.log("Inserting data to google sheet");
    // Insert data to google sheet
    await insertDataInSheet("sector_statuses", dataForGs.getValues());
    return Promise.resolve(true);
  } catch (error) {
    throw new Error(
      `Error processing sector status message for google sheet: ${error}`
    );
  }
};
