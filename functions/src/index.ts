import admin from "firebase-admin";
import {https, logger, pubsub} from "firebase-functions/v2";
import "dotenv/config";
import {processPressureMessageFromPubSub} from "./utils/process_pressure_message";
import {processSectorStatusMessage} from "./utils/process_sector_status_message";
import {processPumpStatusMessage} from "./utils/process_pump_status_message";
import {processPumpFlowMessage} from "./utils/process_pump_flow_message";
import {processPumpPressureMessage} from "./utils/process_pump_pressure_message";
import {processBoardStatusMessage} from "./utils/process_board_status_message";
import {CallableRequest} from "firebase-functions/v2/https";
import {createMqttClient} from "./services/mqtt";
import {httpCallableReqBody} from "./interfaces/interfaces";
import {saveDataWhenDev} from "./utils/save_dev_data";

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

exports.processBoardStatusMessages = pubsub.onMessagePublished(
  "board-status",
  async (event) => {
    const message = event.data.message.json;
    const successInProcessingMessage = await processBoardStatusMessage(message);
    return Promise.resolve(successInProcessingMessage);
  }
);

/**
 * A callable function that handles toggling the status of an item
 * Item can be a pump, sector, board, etc.
 *
 */
exports.toggleItemStatus = https.onCall(async (req: CallableRequest) => {
  try {
    const body: httpCallableReqBody = req.data;
    logger.info(
      `Toggling status of ${body.mqttMsgName} to ${body.message} with topic ${body.topic}`
    );
    const client = await createMqttClient();
    if (client.disconnected) {
      throw new https.HttpsError("internal", "MQTT client is disconnected");
    }
    client.publish(body.topic, body.message);

    // When dev environment is dev, insert manual data to local db
    if (process.env.NODE_ENV === "dev") {
      await saveDataWhenDev(body);
    }

    return {success: true};
  } catch (error) {
    throw new https.HttpsError("internal", error as string);
  }
});
