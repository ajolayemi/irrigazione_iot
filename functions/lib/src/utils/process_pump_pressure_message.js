"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.processPumpPressureMessage = void 0;
const v1_1 = require("firebase-functions/v1");
const read_pump_data_1 = require("../database/pumps/read_pump_data");
const insert_pump_data_1 = require("../database/pumps/insert_pump_data");
const processPumpPressureMessage = async (message) => {
    try {
        if (!message) {
            throw new Error("Message to process is required");
        }
        v1_1.logger.info("Processing pump pressure message...");
        const { nameKey, filterInKey, filterOutKey } = getPumpPressureMessageKeys(message);
        if (!nameKey || !filterInKey || !filterOutKey) {
            throw new Error("Invalid pump pressure message");
        }
        const pump = await (0, read_pump_data_1.getPumpByMqttMsgName)(message[nameKey]);
        if (!pump) {
            throw new Error("No pump found for the pump pressure message");
        }
        v1_1.logger.info(`Pump found for pump pressure message: ${pump.id}`);
        const pumpPressure = {
            created_at: new Date().toISOString(),
            pump_id: pump.id,
            filter_in_pressure: message[filterInKey],
            filter_out_pressure: message[filterOutKey],
        };
        v1_1.logger.info("Saving pump pressure to the database");
        await (0, insert_pump_data_1.insertPumpPressure)(pumpPressure);
        v1_1.logger.info("Pump pressure saved successfully");
        return true;
    }
    catch (error) {
        v1_1.logger.error("Error processing pump pressure message: ", error);
        return false;
    }
};
exports.processPumpPressureMessage = processPumpPressureMessage;
/**
 * Processes the keys in the pump pressure message
 * @param {CustomJSON} msg The message from the MQTT broker
 * @return {PumpPressureKeys} The keys for the pump pressure message
 */
const getPumpPressureMessageKeys = (msg) => {
    // A typical message looks like this:
    // {"IN_CH1":-2.589999914,"OUT_CH2":-2.589999914, “name”: <mqtt-msg-name>}
    const keys = Object.keys(msg);
    const nameKey = keys.filter((key) => key.includes("name"))[0];
    const filterInKey = keys.filter((key) => key.startsWith("IN"))[0];
    const filterOutKey = keys.filter((key) => key.startsWith("OUT"))[0];
    return {
        nameKey,
        filterInKey,
        filterOutKey,
    };
};
//# sourceMappingURL=process_pump_pressure_message.js.map