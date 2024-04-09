import admin from "firebase-admin";
import {pubsub} from "firebase-functions/v2";
import "dotenv/config";
import {processPressureMessageFromPubSub} from "./utils/process_pressure_message";
import {processSectorStatusMessage} from "./utils/process_sector_status_message";

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
