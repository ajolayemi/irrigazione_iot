import {logger} from "firebase-functions/v2";
import {TablesInsert} from "../../../schemas/database.types";
import {CustomJSON, PressureMessageKeys} from "../../interfaces/interfaces";
import {insertTerminalPressure} from "../terminal/insert_terminal_data";
import {
  getCollectorBySectorId,
  getSectorByMqttMsgName,
} from "../sectors/read_sector_data";
import {insertSectorPressure} from "../sectors/insert_sector_data";
import {insertCollectorPressure} from "../collectors/insert_collector_data";

/**
 * Processes the keys in a pressure message to get the keys for terminal pressure,
 * collector pressures and sector pressures
 * @param {CustomJSON} message The message to process the keys from
 * @return {PressureMessageKeys} The keys for terminal pressure, collector pressures and sector pressures
 */
export const getPressureMessageKeys = (
  message: CustomJSON
): PressureMessageKeys => {
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

/**
 * Abstracts the processing of terminal pressure in a pressure message.
 * It's value, if available is stored in the database
 * @param {string} terminalPressureKey The key for terminal pressure in the message
 * @param {CustomJSON} message The message to process terminal pressure from
 * @param {number} collectorId The id of the collector this terminal pressure belongs to
 * @param {Date} timestamp The timestamp of the message
 * @return {Promise<boolean>} True if the terminal pressure was successfully processed, false otherwise
 */
export const processTerminalPressure = async (
  terminalPressureKey: string,
  message: CustomJSON,
  collectorId: number,
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
      collector_id: collectorId,
      pressure: terminalPressure,
    };

    logger.info("Saving terminal pressure to the database");
    await insertTerminalPressure(_terminalPressure);

    return Promise.resolve(true);
  } catch (error) {
    throw new Error(`Error processing terminal pressure: ${error}`);
  }
};

/**
 * Abstracts the processing of sectors pressure in a pressure message.
 * It's values, if available are stored in the database
 * @param {string[]} sectorKeys The keys for sector pressure in the message, as they appear in the message
 * @param {string} message The message to process sector pressure from
 * @param {Date} timestamp The timestamp of the message
 * @return {Promise<boolean>} True if the sector pressure was successfully processed, false otherwise
 */
export const processSectorPressure = async (
  sectorKeys: string[],
  message: CustomJSON,
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
        `Saving sector pressure for sector ${sectorMqttName} to the database`
      );

      // Insert data to database
      await insertSectorPressure(_sectorPressureForDatabase);

      logger.info("Sector pressure saved to the database successfully!");
    }

    return Promise.resolve(true);
  } catch (error) {
    throw new Error(`Error processing sector pressure: ${error}`);
  }
};

/**
 * Abstracts the processing of collector pressure in a pressure message.
 * It's values, if available are stored in the database
 * @param {string[]} collectorPressureKeys The keys for collector pressure in the message
 * @param {CustomJSON} message The message to process collector pressure from
 * @param {number} collectorId The id of the collector this collector pressure belongs to
 * @param {Date} timestamp The timestamp of the message
 * @return {Promise<boolean>} True if the collector pressure was successfully processed, false otherwise
 */
export const processCollectorPressure = async (
  collectorPressureKeys: string[],
  message: CustomJSON,
  collectorId: number,
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
      collector_id: collectorId,
      filter_in_pressure: _filterInPressure,
      filter_out_pressure: _filterOutPressure,
    };

    logger.info("Saving collector pressure to the database");

    // Save the data to database
    await insertCollectorPressure(_collectorPressure);

    return Promise.resolve(true);
  } catch (error) {
    throw new Error(`Error processing collector pressure: ${error}`);
  }
};

/**
 * Tries to get the collector that holds the sectors in a pressure message
 * @param {string[]} sectorKeys The keys for the sector in the message
 * @return {Promise<number | null>} The id of the collector that holds the sectors
 * in the message if found, null otherwise
 */
export const getCollectorForSector = async (
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
