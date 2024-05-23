import {logger} from "firebase-functions/v1";
import {CustomJSON, PumpPressureKeys} from "../interfaces/interfaces";
import {getPumpByMqttMsgName} from "../database/pumps/read_pump_data";
import {insertPumpPressure} from "../database/pumps/insert_pump_data";
import {TablesInsert} from "../../schemas/database.types";
import {getCompanyById} from "../database/companies/read_company_data";
import {PressureWithFilterGs} from "../models/pressure_with_filter_for_gs";
import {customFormatDate} from "./helper_funcs";
import {insertDataInSheet} from "./gs_utils";

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

    logger.info(
      `Saving pump pressure for ${pump.name} to the database and google sheet`
    );
    await insertPumpPressure(pumpPressure);

    // Get the company this pump belongs to
    const company = await getCompanyById(pump.company_id.toString());

    if (!company) {
      throw new Error(
        `No company found for the company with id: ${pump.company_id}`
      );
    }

    const dataForGs = new PressureWithFilterGs(
      pump.id,
      pump.name,
      pump.company_id,
      company.name,
      message[filterInKey],
      message[filterOutKey],
      message[filterInKey] - message[filterOutKey],
      customFormatDate(currentDate)
    );

    await insertDataInSheet("pump_pressures", dataForGs.getValues());

    logger.info(`Pump pressure for ${pump.name} saved successfully`);
    return true;
  } catch (error) {
    logger.error("Error processing pump pressure message: ", error);
    return false;
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
