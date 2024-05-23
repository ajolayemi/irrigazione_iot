import {PressureMessageKeys, CustomJSON} from "../interfaces/interfaces";
import {
  getCollectorBySectorId,
  getSectorByMqttMsgName,
} from "../database/sectors/read_sector_data";
import {logger} from "firebase-functions/v1";
import {Tables, TablesInsert} from "../../schemas/database.types";
import {insertCollectorPressure} from "../database/collectors/insert_collector_data";
import {insertTerminalPressure} from "../database/terminal/insert_terminal_data";
import {insertSectorPressure} from "../database/sectors/insert_sector_data";
import {getCompanyById} from "../database/companies/read_company_data";
import {getCollectorById} from "../database/collectors/read_collector_data";
import {PressureWithFilterGs} from "../models/pressure_with_filter_for_gs";
import {customFormatDate} from "./helper_funcs";
import {insertDataInSheet} from "./gs_utils";
import {SectorPressureGs} from "../models/sector_pressure_for_gs";
import {TerminalPressureForGs} from "../models/terminal_pressure_for_gs";

/**
 * An helper function that helps in processing "pressure" messages sent from
 * the MQTT broker and intercepted by Google PubSub. A typical message looks like this:
 * {"A_CH1":-1.389999986,"B_CH2":-1.399999976,"C_CH3":-1.389999986,
 * "Api_CH4":-1.399999976,"Filter_IN":-1.399999976,"Filter_OUT":-1.399999976, "Final_CH4": -2.569999933,"}
 * @param {CustomJSON} message The message to process
 * @param {boolean} debug A boolean that determines if the function should do some things
 * @return {Promise<boolean>} True if the message was successfully processed, false otherwise
 */
export const processPressureMessageFromPubSub = async (
  message: CustomJSON,
  debug = false
): Promise<boolean> => {
  try {
    const currentDate = new Date();
    if (!message) {
      throw new Error("Message to process is required");
    }
    logger.info("Processing pressure message...");
    logger.info(`With message: ${message.toString()}`);

    // Filter out all necessary keys from the message
    const {
      terminalPressureKey,
      collectorPressureKeys,
      sectorKeys,
      splittedSectorKeys,
    } = getPressureMessageKeys(message);


    // It's expected that at least a single sector key is found in the message
    // If no sector key is found, then the message is invalid
    if (!sectorKeys.length || !splittedSectorKeys.length) {
      throw new Error("No sector key found in the message");
    }

    console.log("sectorKeys", sectorKeys);
    // Get the collector that holds the sectors in the message
    const collectorId = await getCollectorForSector(splittedSectorKeys);

    console.log("collectorId", collectorId);

    if (!collectorId) {
      throw new Error("No collector found for the sectors in the message");
    }

    // Get the real collector object from the database
    const collector = await getCollectorById(collectorId.toString());

    if (!collector) {
      throw new Error(
        `Collector with id ${collectorId} not found in the database`
      );
    }

    // Get the company that this collector belongs to
    const company = await getCompanyById(collector.company_id.toString());

    if (!company) {
      throw new Error(
        `Company with id ${collector.company_id} not found in the database`
      );
    }

    logger.info(
      `Collector found for sectors in the message: ${collector.name}`
    );

    // Reaching here means that the message is valid and the collector that holds
    // the sectors in the message has been found
    // We can now proceed to process the message
    if (!debug) {
      // First, call on the function that handles the terminal pressure message processing
      await processTerminalPressure(
        terminalPressureKey,
        message,
        collector,
        company,
        currentDate
      );
      // Next, call on the function that handles the collector pressure message processing
      await processCollectorPressure(
        collectorPressureKeys,
        message,
        collector,
        company,
        currentDate
      );
      // Finally, call on the function that handles the sector pressure message processing
      await processSectorPressure(
        sectorKeys,
        message,
        collector,
        company,
        currentDate
      );
    }
    return true;
  } catch (error) {
    logger.error("Error processing pressure message: ", error);
    return false;
  }
};

/**
 * Abstracts the processing of sectors pressure in a pressure message.
 * It's values, if available are stored in the database
 * @param {string[]} sectorKeys The keys for sector pressure in the message, as they appear in the message
 * @param {Tables<"collectors">} collector The collector object that holds the sectors in the message
 * @param {Tables<"companies">} company The company that the collector belongs to
 * @param {string} message The message to process sector pressure from
 * @param {Date} timestamp The timestamp of the message
 * @return {Promise<boolean>} True if the sector pressure was successfully processed, false otherwise
 */
export const processSectorPressure = async (
  sectorKeys: string[],
  message: CustomJSON,
  collector: Tables<"collectors">,
  company: Tables<"companies">,
  timestamp: Date
): Promise<boolean> => {
  try {
    logger.info("Processing sector pressure...");

    for (const sectorKey of sectorKeys) {
      const sectorMqttName = sectorKey.split("_")[0];
      // Get the sector id for the sector key
      const sector = await getSectorByMqttMsgName(sectorMqttName);

      if (!sector) {
        logger.info("Skipping sector pressure processing");
        logger.info("No sector found for sector key: ", sectorMqttName);
        continue;
      }

      const sectorPressure = message[sectorKey] as number;

      if (!sectorPressure) {
        logger.info("Exiting... No sector pressure found in the message");
        continue;
      }

      const _sectorPressureForDatabase: TablesInsert<"sector_pressures"> = {
        created_at: timestamp.toISOString(),
        sector_id: sector.id,
        pressure: sectorPressure,
      };

      logger.info(
        `Saving sector pressure for sector ${sectorMqttName} to the database and google sheets`
      );

      // Insert data to database
      await insertSectorPressure(_sectorPressureForDatabase);

      const dataForGs = new SectorPressureGs(
        sector.id,
        sector.name,
        sector.company_id,
        company.name,
        collector.id,
        collector.name,
        sectorPressure,
        customFormatDate(timestamp)
      );

      await insertDataInSheet("sector_pressures", dataForGs.getValues());

      logger.info(
        "Sector pressure saved to the database and google sheet successfully!"
      );
    }

    return true;
  } catch (error) {
    logger.error("Error processing sector pressure: ", error);
    return false;
  }
};
/**
 * Abstracts the processing of collector pressure in a pressure message.
 * It's values, if available are stored in the database
 * @param {string[]} collectorPressureKeys The keys for collector pressure in the message
 * @param {CustomJSON} message The message to process collector pressure from
 * @param {Tables<"collector">} collector The collector object that holds the sectors in the message
 * @param {Tables<"companies">} company The company that the collector belongs to
 * @return {Promise<boolean>} True if the collector pressure was successfully processed, false otherwise
 */
export const processCollectorPressure = async (
  collectorPressureKeys: string[],
  message: CustomJSON,
  collector: Tables<"collectors">,
  company: Tables<"companies">,
  timestamp: Date
): Promise<boolean> => {
  if (!collectorPressureKeys.length) {
    logger.info("Exiting... No collector pressure keys found in the message");
    return false;
  }
  try {
    logger.info("Processing collector pressure...");

    const _filterInPressure = message[collectorPressureKeys[0]] as number;
    const _filterOutPressure = message[collectorPressureKeys[1]] as number;

    const _collectorPressure: TablesInsert<"collector_pressures"> = {
      created_at: timestamp.toISOString(),
      collector_id: collector.id,
      filter_in_pressure: _filterInPressure,
      filter_out_pressure: _filterOutPressure,
    };

    logger.info(`Saving collector pressure to the database and google sheet`);

    // Save the data to database
    await insertCollectorPressure(_collectorPressure);

    // Save to google sheets
    const dataForGs = new PressureWithFilterGs(
      collector.id,
      collector.name,
      company.id,
      company.name,
      _filterInPressure,
      _filterOutPressure,
      _filterInPressure - _filterOutPressure,
      customFormatDate(timestamp)
    );

    await insertDataInSheet("collector_pressures", dataForGs.getValues());
    return true;
  } catch (error) {
    logger.error("Error processing collector pressure: ", error);
    return false;
  }
};

/**
 * Abstracts the processing of terminal pressure in a pressure message.
 * It's value, if available is stored in the database
 * @param {string} terminalPressureKey The key for terminal pressure in the message
 * @param {CustomJSON} message The message to process terminal pressure from
 * @param {Tables<"collectors">} collector The collector object that holds the sectors in the message
 * @param {Tables<"companies">} company The company that the collector belongs to
 * @param {Date} timestamp The timestamp of the message
 * @return {Promise<boolean>} True if the terminal pressure was successfully processed, false otherwise
 */
export const processTerminalPressure = async (
  terminalPressureKey: string,
  message: CustomJSON,
  collector: Tables<"collectors">,
  company: Tables<"companies">,
  timestamp: Date
): Promise<boolean> => {
  try {
    logger.info("Processing terminal pressure...");
    const terminalPressure = message[terminalPressureKey] as number;

    if (!terminalPressure) {
      logger.info("Exiting terminal pressure processing");
      logger.info("No terminal pressure found in the message");
      return false;
    }

    const _terminalPressure: TablesInsert<"terminal_pressures"> = {
      created_at: timestamp.toISOString(),
      collector_id: collector.id,
      pressure: terminalPressure,
    };

    logger.info("Saving terminal pressure to the database and google sheet");
    await insertTerminalPressure(_terminalPressure);

    // Prepare and insert data to google sheet
    const dataForGs = new TerminalPressureForGs(
      collector.id,
      collector.name,
      company.id,
      company.name,
      terminalPressure,
      customFormatDate(timestamp)
    );

    await insertDataInSheet("terminal_pressures", dataForGs.getValues());

    return true;
  } catch (error) {
    logger.error("Error processing terminal pressure: ", error);
    return false;
  }
};

/**
 * Tries to get the collector that holds the sectors in a pressure message
 * @param {string[]} sectorKeys The keys for the sector in the message
 * @return {Promise<number | null>} The id of the collector that holds the sectors
 * in the message if found, null otherwise
 */
const getCollectorForSector = async (
  sectorKeys: Array<string>
): Promise<number | null> => {
  let toReturn = null;

  // Loop through the sector keys to get the sector id
  // and stop at the first sector that has a collector
  for (const sectorKey of sectorKeys) {
    // call on the function that gets sectors by mqtt message name
    const sectorId = await getSectorByMqttMsgName(sectorKey);

    if (!sectorId) {
      continue;
    }

    // The internal rules are that a sector can only belong to a single collector
    // and a collector can have multiple sectors.
    // Knowing this, we can get the collector that holds the sector
    // and assign the various pressure values to the collector
    const collector = await getCollectorBySectorId(sectorId.id.toString());

    if (collector) {
      toReturn = collector.collector_id;
      break;
    }
  }

  return toReturn;
};

/**
 * Processes the keys in a pressure message to get the keys for terminal pressure,
 * collector pressures and sector pressures
 * @param {CustomJSON} message The message to process the keys from
 * @return {PressureMessageKeys} The keys for terminal pressure, collector pressures and sector pressures
 */
const getPressureMessageKeys = (message: CustomJSON): PressureMessageKeys => {
  // Get a list of keys available in the message
  const keys = Object.keys(message as object);

  // Get the ket for terminal pressure, it's represented by the key "Final_CH4"
  // to do this, we filter the keys to get the one that has the word "Final" in it
  const terminalPressureKey = keys.filter((key) =>
    key.includes("Final")
  )[0] as string;

  // Get the keys for collector pressures, they are represented by all keys
  // that start with Filter
  const collectorPressureKeys = keys.filter((key) => key.startsWith("Filter"));

  // Get all other keys that are not terminal pressure or collector pressure keys
  // These are the sector keys and they should be splitted to remove the "_CH" part
  const sectorKeys = keys.filter(
    (key) => !collectorPressureKeys.includes(key) && key !== terminalPressureKey
  );

  const splittedSectorKeys = sectorKeys.map((key) => key.split("_")[0]);

  return {
    terminalPressureKey,
    collectorPressureKeys,
    sectorKeys,
    splittedSectorKeys,
  };
};
