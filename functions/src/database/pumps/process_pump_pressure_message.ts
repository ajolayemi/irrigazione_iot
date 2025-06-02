import {logger} from "firebase-functions/v1";
import {CustomJSON, PumpPressureKeys} from "../../interfaces/interfaces";
import {getPumpById, getPumpByMqttMsgName} from "./read_pump_data";
import {insertPumpPressure} from "./insert_pump_data";
import {TablesInsert} from "../../../schemas/database.types";
import {getCompanyById} from "../companies/read_company_data";
import {PressureWithFilterGs} from "../../models/pressure_with_filter_for_gs";
import {customFormatDate} from "../../utils/helper_funcs";
import {insertDataInSheet} from "../../utils/gs_utils";

export const processPumpPressureMessage = async (
  message: CustomJSON
): Promise<boolean> => {
  try {
    if (!message) {
      throw new Error("Message to process is required");
    }

    logger.info("Processing pump pressure message...");

    const {nameKey, filterInKey, filterOutKey} =
      getPumpPressureMessageKeys(message);

    if (!nameKey || !filterInKey || !filterOutKey) {
      throw new Error("Invalid pump pressure message");
    }

    const pump = await getPumpByMqttMsgName(message[nameKey]);

    if (!pump) {
      throw new Error(
        `No pump found for the pump with mqtt name: ${message[nameKey]}`
      );
    }

    const currentDate = new Date();

    const pumpPressure: TablesInsert<"pump_pressures"> = {
      created_at: currentDate.toISOString(),
      pump_id: pump.id,
      filter_in_pressure: message[filterInKey],
      filter_out_pressure: message[filterOutKey],
    };

    logger.info(`Saving pump pressure for ${pump.name} to the database`);
    await insertPumpPressure(pumpPressure);

    logger.info(`Pump pressure for ${pump.name} saved successfully`);
    return Promise.resolve(true);
  } catch (error) {
    throw new Error("Error processing pump pressure message");
  }
};

/**
 * Processes pump pressure data for Google Sheets
 * @param {TablesInsert<"pump_pressures">} data The pump pressure data to process
 * @return {Promise<boolean>} A promise that resolves to true if the pump pressure data
 * was processed successfully
 */
export const processPumpPressureDataForGs = async (
  data: TablesInsert<"pump_pressures">
): Promise<boolean> => {
  if (!data) {
    throw new Error(
      "Data to process pump pressure for google sheets is undefined"
    );
  }

  console.log("Processing pump pressure for google sheets with data:");
  console.log(data);
  try {
    // Get the pump this pressure data belongs to
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
    const dataForGs = new PressureWithFilterGs(
      pump.id,
      pump.name,
      pump.company_id,
      company.name,
      data.filter_in_pressure ?? 0,
      data.filter_out_pressure ?? 0,
      data.pressure_difference ?? 0,
      customFormatDate(data.created_at)
    );

    await insertDataInSheet("pump_pressures", dataForGs.getValues());
    return Promise.resolve(true);
  } catch (error) {
    throw new Error("Error processing pump pressure for google sheets");
  }
};

/**
 * Processes the keys in the pump pressure message
 * @param {CustomJSON} msg The message from the MQTT broker
 * @return {PumpPressureKeys} The keys for the pump pressure message
 */
const getPumpPressureMessageKeys = (msg: CustomJSON): PumpPressureKeys => {
  // A typical message looks like this:
  // {"IN_CH1":-2.589999914,"OUT_CH2":-2.589999914, “name”: <mqtt-msg-name>}
  const keys = Object.keys(msg);

  const nameKey = keys.filter((key) => key.includes("name"))[0] as string;
  const filterInKey = keys.filter((key) => key.startsWith("IN"))[0] as string;
  const filterOutKey = keys.filter((key) => key.startsWith("OUT"))[0] as string;

  return {
    nameKey,
    filterInKey,
    filterOutKey,
  };
};
