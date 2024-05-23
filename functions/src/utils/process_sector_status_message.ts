import {logger} from "firebase-functions/v2";
import {StatusMessage} from "../interfaces/interfaces";
import {
  getCollectorBySectorId,
  getSectorByMqttMsgName,
} from "../database/sectors/read_sector_data";
import {TablesInsert} from "../../schemas/database.types";
import {insertSectorStatus} from "../database/sectors/insert_sector_data";
import {getCompanyById} from "../database/companies/read_company_data";
import {getCollectorById} from "../database/collectors/read_collector_data";
import {SectorStatusGs} from "../models/sector_status_for_gs";
import {customFormatDate} from "./helper_funcs";
import {insertDataInSheet} from "./gs_utils";

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

    logger.info(
      `Inserting sector status for ${sectorName} into database and google sheet`
    );
    // Insert data to the database
    await insertSectorStatus(sectorStatus);

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
      sectorStatus.status_boolean ?? false,
      customFormatDate(currentDate)
    );

    // Insert data to google sheet
    await insertDataInSheet("sector_statuses", dataForGs.getValues());

    logger.info(`Sector status for ${sectorName} inserted successfully`);
    return true;
  } catch (error) {
    logger.error("Error processing sector status message", error);
    return false;
  }
};
