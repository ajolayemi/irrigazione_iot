"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.processPressureMessageFromPubSub = void 0;
const read_sector_data_1 = require("../database/sectors/read_sector_data");
const v1_1 = require("firebase-functions/v1");
const insert_collector_data_1 = require("../database/collectors/insert_collector_data");
const insert_terminal_data_1 = require("../database/terminal/insert_terminal_data");
const insert_sector_data_1 = require("../database/sectors/insert_sector_data");
/**
 * An helper function that helps in processing "pressure" messages sent from
 * the MQTT broker and intercepted by Google PubSub. A typical message looks like this:
 * {"A_CH1":-1.389999986,"B_CH2":-1.399999976,"C_CH3":-1.389999986,
 * "Api_CH4":-1.399999976,"Filter_IN":-1.399999976,"Filter_OUT":-1.399999976, "Final_CH4": -2.569999933,"}
 * @param {CustomJSON} message The message to process
 * @param {boolean} debug A boolean that determines if the function should do some things
 * @return {Promise<boolean>} True if the message was successfully processed, false otherwise
 */
const processPressureMessageFromPubSub = async (message, debug = false) => {
    try {
        if (!message) {
            throw new Error("Message to process is required");
        }
        v1_1.logger.info("Processing pressure message...");
        v1_1.logger.info(`With message: ${message}`);
        // Filter out all necessary keys from the message
        const { terminalPressureKey, collectorPressureKeys, sectorKeys, splittedSectorKeys, } = getPressureMessageKeys(message);
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
        v1_1.logger.info(`Collector found for sectors in the message: ${collectorId}`);
        // Reaching here means that the message is valid and the collector that holds
        // the sectors in the message has been found
        // We can now proceed to process the message
        if (!debug) {
            // First, call on the function that handles the terminal pressure message processing
            await processTerminalPressure(terminalPressureKey, message, collectorId);
            // Next, call on the function that handles the collector pressure message processing
            await processCollectorPressure(collectorPressureKeys, message, collectorId);
            // Finally, call on the function that handles the sector pressure message processing
            await processSectorPressure(sectorKeys, message);
        }
        return true;
    }
    catch (error) {
        v1_1.logger.error("Error processing pressure message: ", error);
        return false;
    }
};
exports.processPressureMessageFromPubSub = processPressureMessageFromPubSub;
/**
 * Abstracts the processing of sectors pressure in a pressure message.
 * It's values, if available are stored in the database
 * @param {string[]} sectorKeys The keys for sector pressure in the message, as they appear in the message
 * @param {string} message The message to process sector pressure from
 * @return {Promise<boolean>} True if the sector pressure was successfully processed, false otherwise
 */
const processSectorPressure = async (sectorKeys, message) => {
    try {
        v1_1.logger.info("Processing sector pressure...");
        for (const sectorKey of sectorKeys) {
            const sectorMqttName = sectorKey.split("_")[0];
            // Get the sector id for the sector key
            const sector = await (0, read_sector_data_1.getSectorByMqttMsgName)(sectorMqttName);
            if (!sector) {
                v1_1.logger.info("Skipping sector pressure processing");
                v1_1.logger.info("No sector found for sector key: ", sectorMqttName);
                continue;
            }
            const sectorPressure = message[sectorKey].toFixed(2);
            const _sectorPressureForDatabase = {
                created_at: new Date().toISOString(),
                sector_id: sector.id,
                pressure: sectorPressure,
            };
            v1_1.logger.info(`Saving sector pressure for sector ${sectorMqttName} to the database`);
            await (0, insert_sector_data_1.insertSectorPressure)(_sectorPressureForDatabase);
        }
        return true;
    }
    catch (error) {
        v1_1.logger.error("Error processing sector pressure: ", error);
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
const processCollectorPressure = async (collectorPressureKeys, message, collectorId) => {
    try {
        v1_1.logger.info("Processing collector pressure...");
        const _filterInPressure = message[collectorPressureKeys[0]].toFixed(2);
        const _filterOutPressure = message[collectorPressureKeys[1]].toFixed(2);
        const _collectorPressure = {
            created_at: new Date().toISOString(),
            collector_id: collectorId,
            filter_in_pressure: _filterInPressure,
            filter_out_pressure: _filterOutPressure,
        };
        // Save the data to database
        await (0, insert_collector_data_1.insertCollectorPressure)(_collectorPressure);
        return true;
    }
    catch (error) {
        v1_1.logger.error("Error processing collector pressure: ", error);
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
const processTerminalPressure = async (terminalPressureKey, message, collectorId) => {
    try {
        const terminalPressure = message[terminalPressureKey].toFixed(2);
        if (!terminalPressure) {
            v1_1.logger.info("Exiting terminal pressure processing");
            v1_1.logger.info("No terminal pressure found in the message");
            return false;
        }
        const _terminalPressure = {
            created_at: new Date().toISOString(),
            collector_id: collectorId,
            pressure: terminalPressure,
        };
        v1_1.logger.info("Saving terminal pressure to the database");
        await (0, insert_terminal_data_1.insertTerminalPressure)(_terminalPressure);
        return true;
    }
    catch (error) {
        v1_1.logger.error("Error processing terminal pressure: ", error);
        return false;
    }
};
/**
 * Tries to get the collector that holds the sectors in a pressure message
 * @param {string[]} sectorKeys The keys for the sector in the message
 * @return {Promise<number | null>} The id of the collector that holds the sectors
 * in the message if found, null otherwise
 */
const getCollectorForSector = async (sectorKeys) => {
    let toReturn = null;
    // Loop through the sector keys to get the sector id
    // and stop at the first sector that has a collector
    for (const sectorKey of sectorKeys) {
        // call on the function that gets sectors by mqtt message name
        const sectorId = await (0, read_sector_data_1.getSectorByMqttMsgName)(sectorKey);
        if (!sectorId) {
            continue;
        }
        // The internal rules are that a sector can only belong to a single collector
        // and a collector can have multiple sectors.
        // Knowing this, we can get the collector that holds the sector
        // and assign the various pressure values to the collector
        const collector = await (0, read_sector_data_1.getCollectorBySectorId)(sectorId.id.toString());
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
const getPressureMessageKeys = (message) => {
    // Get a list of keys available in the message
    const keys = Object.keys(message);
    // Get the ket for terminal pressure, it's represented by the key "Final_CH4"
    // to do this, we filter the keys to get the one that has the word "Final" in it
    const terminalPressureKey = keys.filter((key) => key.includes("Final"))[0];
    // Get the keys for collector pressures, they are represented by all keys
    // that start with Filter
    const collectorPressureKeys = keys.filter((key) => key.startsWith("Filter"));
    // Get all other keys that are not terminal pressure or collector pressure keys
    // These are the sector keys and they should be splitted to remove the "_CH" part
    const sectorKeys = keys.filter((key) => !collectorPressureKeys.includes(key) && key !== terminalPressureKey);
    const splittedSectorKeys = sectorKeys.map((key) => key.split("_")[0]);
    return {
        terminalPressureKey,
        collectorPressureKeys,
        sectorKeys,
        splittedSectorKeys,
    };
};
//# sourceMappingURL=process_pressure_message.js.map