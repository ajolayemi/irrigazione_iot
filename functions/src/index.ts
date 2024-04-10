import admin from "firebase-admin";
import {pubsub} from "firebase-functions/v2";
import "dotenv/config";
import {processPressureMessageFromPubSub} from "./utils/process_pressure_message";
import {processSectorStatusMessage} from "./utils/process_sector_status_message";
import {processPumpStatusMessage} from "./utils/process_pump_status_message";
import {processPumpFlowMessage} from "./utils/process_pump_flow_message";
import {processPumpPressureMessage} from "./utils/process_pump_pressure_message";

admin.initializeApp();

/**
 * Cloud function is triggered by a message published to the `pressure` topic
 */
exports.processPressureMessages = pubsub.onMessagePublished(
  "pressure",
  async (event) => {
    const message = event.data.message.json;
    const successInProcessingMessage = await processPressureMessageFromPubSub(
      message
    );
    return Promise.resolve(successInProcessingMessage);
  }
);

/**
 * Cloud function triggered by a message published to the `sector-status` topic
 */
exports.processSectorStatusMessages = pubsub.onMessagePublished(
  "sector-status",
  async (event) => {
    const message = event.data.message.json;
    const successInProcessingMessage = await processSectorStatusMessage(
      message
    );
    return Promise.resolve(successInProcessingMessage);
  }
);

exports.processPumpStatusMessages = pubsub.onMessagePublished(
  "pump-status",
  async (event) => {
    const message = event.data.message.json;
    const successInProcessingMessage = await processPumpStatusMessage(message);
    return Promise.resolve(successInProcessingMessage);
  }
);

exports.processPumpFlowMessages = pubsub.onMessagePublished(
  "pump-flow",
  async (event) => {
    const message = event.data.message.json;
    const successInProcessingMessage = await processPumpFlowMessage(message);
    return Promise.resolve(successInProcessingMessage);
  }
);

exports.processPumpPumpPressureMessages = pubsub.onMessagePublished(
  "pump-pressure",
  async (event) => {
    const message = event.data.message.json;
    const successInProcessingMessage = await processPumpPressureMessage(
      message
    );
    return Promise.resolve(successInProcessingMessage);
  }
);
