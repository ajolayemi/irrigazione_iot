"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const firebase_admin_1 = require("firebase-admin");
const v2_1 = require("firebase-functions/v2");
require("dotenv/config");
const process_pressure_message_1 = require("./utils/process_pressure_message");
const process_sector_status_message_1 = require("./utils/process_sector_status_message");
const process_pump_status_message_1 = require("./utils/process_pump_status_message");
const process_pump_flow_message_1 = require("./utils/process_pump_flow_message");
const process_pump_pressure_message_1 = require("./utils/process_pump_pressure_message");
firebase_admin_1.default.initializeApp();
/**
 * Cloud function is triggered by a message published to the `pressure` topic
 */
exports.processPressureMessages = v2_1.pubsub.onMessagePublished("pressure", async (event) => {
    const message = event.data.message.json;
    const successInProcessingMessage = await (0, process_pressure_message_1.processPressureMessageFromPubSub)(message);
    return Promise.resolve(successInProcessingMessage);
});
/**
 * Cloud function triggered by a message published to the `sector-status` topic
 */
exports.processSectorStatusMessages = v2_1.pubsub.onMessagePublished("sector-status", async (event) => {
    const message = event.data.message.json;
    const successInProcessingMessage = await (0, process_sector_status_message_1.processSectorStatusMessage)(message);
    return Promise.resolve(successInProcessingMessage);
});
exports.processPumpStatusMessages = v2_1.pubsub.onMessagePublished("pump-status", async (event) => {
    const message = event.data.message.json;
    const successInProcessingMessage = await (0, process_pump_status_message_1.processPumpStatusMessage)(message);
    return Promise.resolve(successInProcessingMessage);
});
exports.processPumpFlowMessages = v2_1.pubsub.onMessagePublished("pump-flow", async (event) => {
    const message = event.data.message.json;
    const successInProcessingMessage = await (0, process_pump_flow_message_1.processPumpFlowMessage)(message);
    return Promise.resolve(successInProcessingMessage);
});
exports.processPumpPumpPressureMessages = v2_1.pubsub.onMessagePublished("pump-pressure", async (event) => {
    const message = event.data.message.json;
    const successInProcessingMessage = await (0, process_pump_pressure_message_1.processPumpPressureMessage)(message);
    return Promise.resolve(successInProcessingMessage);
});
//# sourceMappingURL=index.js.map