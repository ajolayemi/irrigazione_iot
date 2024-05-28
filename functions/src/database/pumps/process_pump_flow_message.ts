import {logger} from "firebase-functions/v2";
import {PumpFlowRateMessage} from "../../interfaces/interfaces";
import {getPumpById, getPumpByMqttMsgName} from "./read_pump_data";
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

    logger.info(`Inserting pump flow for ${name} into database`);
    const flowRate: TablesInsert<"pump_flows"> = {
      created_at: currentDate.toISOString(),
      pump_id: pump.id,
      flow: count * 100,
      litres_per_second: message.litresPerSecond,
    };

    // Insert data to supabase
    await insertPumpFlow(flowRate);

    logger.info(`Pump flow for ${name} inserted successfully`);
    return Promise.resolve(true);
  } catch (error) {
    throw new Error("Error processing pump flow message");
  }
};

/**
 * Processes pump flow data for google sheets
 * @param {TablesInsert<"pump_flows">} data The pump flow data to process
 * @return {Promise<boolean>} A promise that resolves to true if the pump flow data
 * was processed successfully
 */
export const processPumpFlowDataForGs = async (
  data: TablesInsert<"pump_flows">
): Promise<boolean> => {
  if (!data) {
    throw new Error("Data to process pump flow for google sheets is undefined");
  }

  console.log("Processing pump flow for google sheets with data:");
  console.log(data);
  try {
    // Get the pump this flow data belongs to
    const pump = await getPumpById(data.pump_id.toString());

    if (!pump) {
      throw new Error(
        `No pump matching the provided ${data.pump_id} was found in database`
      );
    }

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
      data.flow,
      data.litres_per_second ?? 0,
      customFormatDate(data.created_at)
    );

    await insertDataInSheet("pump_flows", dataForGs.getValues());

    return Promise.resolve(true);
  } catch (error) {
    throw new Error("Error processing pump flow for google sheets");
  }
};
