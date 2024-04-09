"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.processSectorStatusMessage = void 0;
const v2_1 = require("firebase-functions/v2");
const read_sector_data_1 = require("../database/sectors/read_sector_data");
const insert_sector_data_1 = require("../database/sectors/insert_sector_data");
/**
 * Abstracts off the process of sector status message coming from
 * MQTT - Dataflow - PubSub. It basically process the message and insert
 * the sector status into the database
 * @param {StatusMessage} message The sector status message to process
 * @return {Promise<boolean>} A promise that resolves to true if the sector
 * status message was processed successfully, otherwise false
 */
const processSectorStatusMessage = async (message) => {
    try {
        if (!message) {
            throw new Error("Message to process sector status is undefined");
        }
        v2_1.logger.info(`Processing sector status message for ${message.name}`);
        const sectorName = message.name;
        const status = message.status;
        // get the sector by the provided name (mqtt-msg-name column in database)
        const sector = await (0, read_sector_data_1.getSectorByMqttMsgName)(sectorName);
        if (!sector) {
            throw new Error(`No sector matching the provided ${sectorName} was found in database`);
        }
        // insert the sector status into the database
        // this is the status of the sector's pump
        const sectorStatus = {
            created_at: new Date().toISOString(),
            sector_id: sector.id,
            status,
        };
        v2_1.logger.info(`Inserting sector status for ${sectorName} into database`);
        await (0, insert_sector_data_1.insertSectorStatus)(sectorStatus);
        v2_1.logger.info(`Sector status for ${sectorName} inserted successfully`);
        return true;
    }
    catch (error) {
        v2_1.logger.error("Error processing sector status message", error);
        return false;
    }
};
exports.processSectorStatusMessage = processSectorStatusMessage;
//# sourceMappingURL=process_sector_status_message.js.map