import admin from "firebase-admin";
import {logger} from "firebase-functions/v1";
import {pubsub} from "firebase-functions/v2";
import {processPressureMessageFromPubSub} from "./utils/process_pressure_message";
// import {processPressureMessageFromPubSub} from "./utils/process_pressure_message";

admin.initializeApp();

exports.processPressureMessages = pubsub.onMessagePublished(
  "pressure",
  async (event) => {
    const message = event.data.message;
    const data = Buffer.from(message.data, "base64").toJSON();
    logger.info(`Received pressure message: ${JSON.stringify(data)}`);
    const successInProcessingMessage = await processPressureMessageFromPubSub(
      data
    );
    return Promise.resolve(successInProcessingMessage);
  }
);
