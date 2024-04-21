import {logger} from "firebase-functions/v2";
import {StatusMessage} from "../interfaces/interfaces";
import {getSectorByMqttMsgName} from "../database/sectors/read_sector_data";
import {TablesInsert} from "../../schemas/database.types";
import {insertSectorStatus} from "../database/sectors/insert_sector_data";

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

    // insert the sector status into the database
    // this is the status of the sector's pump
    const sectorStatus: TablesInsert<"sector_statuses"> = {
      created_at: new Date().toISOString(),
      sector_id: sector.id,
      status,
    };

    logger.info(`Inserting sector status for ${sectorName} into database`);
    await insertSectorStatus(sectorStatus);
    logger.info(`Sector status for ${sectorName} inserted successfully`);
    return true;
  } catch (error) {
    logger.error("Error processing sector status message", error);
    return false;
  }
};
