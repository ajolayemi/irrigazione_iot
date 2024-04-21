"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.processPumpFlowMessage = void 0;
const v2_1 = require("firebase-functions/v2");
const read_pump_data_1 = require("../database/pumps/read_pump_data");
const insert_pump_data_1 = require("../database/pumps/insert_pump_data");
/**
 * Abstracts the process of a pump flow message
 * @param {PumpFlowRateMessage} message The pump flow message to process
 * @return {Promise<boolean>} A promise that resolves to true if the pump flow message
 * was processed successfully, otherwise false
 */
const processPumpFlowMessage = async (message) => {
    try {
        if (!message) {
            throw new Error("Message to process pump flow is undefined");
        }
        v2_1.logger.info(`Processing pump flow message for ${message.name}`);
        const { name, count } = message;
        const pump = await (0, read_pump_data_1.getPumpByMqttMsgName)(name);
        if (!pump) {
            throw new Error(`No pump matching the provided ${name} was found in database`);
        }
        v2_1.logger.info(`Inserting pump flow for ${name} into database`);
        const flowRate = {
            created_at: new Date().toISOString(),
            pump_id: pump.id,
            flow: count * 100,
        };
        await (0, insert_pump_data_1.insertPumpFlow)(flowRate);
        v2_1.logger.info(`Pump flow for ${name} inserted successfully`);
        return true;
    }
    catch (error) {
        v2_1.logger.error("Error processing pump flow message", error);
        return false;
    }
};
exports.processPumpFlowMessage = processPumpFlowMessage;
//# sourceMappingURL=process_pump_flow_message.js.map