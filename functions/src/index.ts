import admin from "firebase-admin";
import {pubsub} from "firebase-functions/v2";
import {processPressureMessageFromPubSub} from "./utils/process_pressure_message";

admin.initializeApp();

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
