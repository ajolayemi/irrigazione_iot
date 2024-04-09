import {PressureMessageKeys, CustomJSON} from "../interfaces/interfaces";
import {
  getCollectorBySectorId,
  getSectorByMqttMsgName,
} from "../database/sectors/read_sector_data";
import {logger} from "firebase-functions/v1";
import {TablesInsert} from "../../schemas/database.types";
import {insertCollectorPressure} from "../database/collectors/insert_collector_data";
import {insertTerminalPressure} from "../database/terminal/insert_terminal_data";
import {insertSectorPressure} from "../database/sectors/insert_sector_data";

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
    if (!message) {
      throw new Error("Message to process is required");
    }
    logger.info("Processing pressure message...");
    logger.info(`With message: ${message}`);

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

    // Get the collector that holds the sectors in the message
    const collectorId = await getCollectorForSector(splittedSectorKeys);

    if (!collectorId) {
      throw new Error("No collector found for the sectors in the message");
    }

    // Reaching here means that the message is valid and the collector that holds
    // the sectors in the message has been found
    // We can now proceed to process the message
    if (!debug) {
      // First, call on the function that handles the terminal pressure message processing
      await processTerminalPressure(terminalPressureKey, message, collectorId);
      // Next, call on the function that handles the collector pressure message processing
      await processCollectorPressure(
        collectorPressureKeys,
        message,
        collectorId
      );
      // Finally, call on the function that handles the sector pressure message processing
      await processSectorPressure(sectorKeys, message);
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
 * @param {string} message The message to process sector pressure from
 * @return {Promise<boolean>} True if the sector pressure was successfully processed, false otherwise
 */
const processSectorPressure = async (
  sectorKeys: string[],
  message: CustomJSON
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

      const sectorPressure = message[sectorKey].toFixed(2) as number;

      const _sectorPressureForDatabase: TablesInsert<"sector_pressures"> = {
        created_at: new Date().toISOString(),
        sector_id: sector.id,
        pressure: sectorPressure,
      };

      logger.info(
        `Saving sector pressure for sector ${sectorMqttName} to the database`
      );
      await insertSectorPressure(_sectorPressureForDatabase);
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
 * @param {number} collectorId The id of the collector that holds the sectors in the message
 * @return {Promise<boolean>} True if the collector pressure was successfully processed, false otherwise
 */
const processCollectorPressure = async (
  collectorPressureKeys: string[],
  message: CustomJSON,
  collectorId: number
): Promise<boolean> => {
  try {
    logger.info("Processing collector pressure...");

    const _filterInPressure = message[collectorPressureKeys[0]].toFixed(
      2
    ) as number;
    const _filterOutPressure = message[collectorPressureKeys[1]].toFixed(
      2
    ) as number;

    const _collectorPressure: TablesInsert<"collector_pressures"> = {
      created_at: new Date().toISOString(),
      collector_id: collectorId,
      filter_in_pressure: _filterInPressure,
      filter_out_pressure: _filterOutPressure,
    };

    // Save the data to database
    await insertCollectorPressure(_collectorPressure);

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
 * @param {number} collectorId The id of the collector that holds the sectors in the message
 * @return {Promise<boolean>} True if the terminal pressure was successfully processed, false otherwise
 */
const processTerminalPressure = async (
  terminalPressureKey: string,
  message: CustomJSON,
  collectorId: number
): Promise<boolean> => {
  try {
    const terminalPressure = message[terminalPressureKey].toFixed(2) as number;

    if (!terminalPressure) {
      logger.info("Exiting terminal pressure processing");
      logger.info("No terminal pressure found in the message");
      return false;
    }

    const _terminalPressure: TablesInsert<"terminal_pressures"> = {
      created_at: new Date().toISOString(),
      collector_id: collectorId,
      pressure: terminalPressure,
    };
    logger.info("Saving terminal pressure to the database");

    await insertTerminalPressure(_terminalPressure);

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
      toReturn = collector.id;
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
