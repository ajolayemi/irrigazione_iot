import {logger} from "firebase-functions/v2";
import {PumpFlowRateMessage} from "../../interfaces/interfaces";
import {getPumpByMqttMsgName} from "./read_pump_data";
import {TablesInsert} from "../../../schemas/database.types";
import {insertPumpFlow} from "./insert_pump_data";
import {PumpFlowGs} from "../../models/pump_flow_for_gs";
import {customFormatDate} from "../../utils/helper_funcs";
import {insertDataInSheet} from "../../utils/gs_utils";
import {getCompanyById} from "../companies/read_company_data";

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

    const currentDate = new Date();

    logger.info(
      `Inserting pump flow for ${name} into database and google sheet`
    );
    const flowRate: TablesInsert<"pump_flows"> = {
      created_at: currentDate.toISOString(),
      pump_id: pump.id,
      flow: count * 100,
      litres_per_second: message.litresPerSecond,
    };

    // Insert data to supabase
    await insertPumpFlow(flowRate);

    // Get the company this pump belongs to
    const company = await getCompanyById(pump.company_id.toString());

    if (!company) {
      throw new Error(
        `No company matching the provided ${pump.company_id} was found`
      );
    }

    // Insert data to google sheets
    const dataForGs = new PumpFlowGs(
      pump.id,
      pump.name,
      pump.company_id,
      company.name,
      flowRate.flow,
      message.litresPerSecond,
      customFormatDate(currentDate)
    );

    await insertDataInSheet("pump_flows", dataForGs.getValues());

    logger.info(`Pump flow for ${name} inserted successfully`);
    return true;
  } catch (error) {
    logger.error("Error processing pump flow message", error);
    return false;
  }
};
