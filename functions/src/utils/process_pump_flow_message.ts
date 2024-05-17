import {logger} from "firebase-functions/v2";
import {PumpFlowRateMessage} from "../interfaces/interfaces";
import {getPumpByMqttMsgName} from "../database/pumps/read_pump_data";
import {TablesInsert} from "../../schemas/database.types";
import {insertPumpFlow} from "../database/pumps/insert_pump_data";

/**
 * Abstracts the process of a pump flow message
 * @param {PumpFlowRateMessage} message The pump flow message to process
 * @return {Promise<boolean>} A promise that resolves to true if the pump flow message
 * was processed successfully, otherwise false
 */
export const processPumpFlowMessage = async (
  message: PumpFlowRateMessage
): Promise<boolean> => {
  try {
    if (!message) {
      throw new Error("Message to process pump flow is undefined");
    }

    logger.info(`Processing pump flow message for ${message.name}`);
    const {name, count} = message;

    const pump = await getPumpByMqttMsgName(name);

    if (!pump) {
      throw new Error(
        `No pump matching the provided ${name} was found in database`
      );
    }

    logger.info(`Inserting pump flow for ${name} into database`);
    const flowRate: TablesInsert<"pump_flows"> = {
      created_at: new Date().toISOString(),
      pump_id: pump.id,
      flow: count * 100,
      litres_per_second: message.litresPerSecond,
    };

    await insertPumpFlow(flowRate);
    logger.info(`Pump flow for ${name} inserted successfully`);
    return true;
  } catch (error) {
    logger.error("Error processing pump flow message", error);
    return false;
  }
};
