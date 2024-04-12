"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.processPumpStatusMessage = void 0;
const v2_1 = require("firebase-functions/v2");
const read_pump_data_1 = require("../database/pumps/read_pump_data");
const insert_pump_data_1 = require("../database/pumps/insert_pump_data");
/**
 * Abstracts the process of a pump status message coming from
 * MQTT - Dataflow - PubSub. It processes the message and inserts
 * the pump status into the database
 * @param {StatusMessage} message The pump status message to process
 * @return {Promise<boolean>} A promise that resolves to true if the pump
 * status message was processed successfully, otherwise false
 */
const processPumpStatusMessage = async (message) => {
    try {
        if (!message) {
            throw new Error("Message to process for pump status is undefined");
        }
        v2_1.logger.info(`Processing pump status message for ${message.name}`);
        const pumpName = message.name;
        const status = message.status;
        // get the pump by the provided name (mqtt-msg-name column in database)
        const pump = await (0, read_pump_data_1.getPumpByMqttMsgName)(pumpName);
        if (!pump) {
            throw new Error(`No pump matching the provided ${pumpName} was found in database`);
        }
        // insert the pump status into the database
        const pumpStatus = {
            created_at: new Date().toISOString(),
            pump_id: pump.id,
            status,
        };
        v2_1.logger.info(`Inserting pump status for ${pumpName} into database`);
        await (0, insert_pump_data_1.insertPumpStatus)(pumpStatus);
        v2_1.logger.info(`Pump status for ${pumpName} inserted successfully`);
        return true;
    }
    catch (error) {
        v2_1.logger.error("Error processing pump status message", error);
        return false;
    }
};
exports.processPumpStatusMessage = processPumpStatusMessage;
//# sourceMappingURL=process_pump_status_message.js.map