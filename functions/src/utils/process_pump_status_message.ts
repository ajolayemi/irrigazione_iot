import {logger} from "firebase-functions/v2";
import {StatusMessage} from "../interfaces/interfaces";
import {getPumpByMqttMsgName} from "../database/pumps/read_pump_data";
import {TablesInsert} from "../../schemas/database.types";
import {insertPumpStatus} from "../database/pumps/insert_pump_data";

/**
 * Abstracts the process of a pump status message coming from
 * MQTT - Dataflow - PubSub. It processes the message and inserts
 * the pump status into the database
 * @param {StatusMessage} message The pump status message to process
 * @return {Promise<boolean>} A promise that resolves to true if the pump
 * status message was processed successfully, otherwise false
 */
export const processPumpStatusMessage = async (
  message: StatusMessage
): Promise<boolean> => {
  try {
    if (!message) {
      throw new Error("Message to process for pump status is undefined");
    }

    logger.info(`Processing pump status message for ${message.name}`);
    const pumpName = message.name;
    const status = message.status;

    // get the pump by the provided name (mqtt-msg-name column in database)
    const pump = await getPumpByMqttMsgName(pumpName);

    if (!pump) {
      throw new Error(
        `No pump matching the provided ${pumpName} was found in database`
      );
    }

    // insert the pump status into the database
    const pumpStatus: TablesInsert<"pump_statuses"> = {
      created_at: new Date().toISOString(),
      pump_id: pump.id,
      status,
    };

    logger.info(`Inserting pump status for ${pumpName} into database`);
    await insertPumpStatus(pumpStatus);
    logger.info(`Pump status for ${pumpName} inserted successfully`);
    return true;
  } catch (error) {
    logger.error("Error processing pump status message", error);
    return false;
  }
};
