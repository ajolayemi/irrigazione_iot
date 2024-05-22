import admin from "firebase-admin";
import {https, logger, pubsub} from "firebase-functions/v2";
import {CallableRequest} from "firebase-functions/v2/https";
import {createMqttClient} from "./services/mqtt";
import {HttpCallableReqBody, StatusMessage} from "./interfaces/interfaces";
import {saveDataWhenDev} from "./utils/save_dev_data";
import {processSenseCapData} from "./utils/process_sense_cap_data";
import {
  getDecodedPayloadMsg,
  switchBaseOnMessageType,
} from "./utils/helper_funcs";

import "dotenv/config";
admin.initializeApp();

/**
 * Listens to new messages on the 'saia-dataflow' topic
 * from PubSub and tries to pass the message to the
 * appropriate function for processing.
 *
 */
exports.processDataflowMessages = pubsub.onMessagePublished(
  "saia-dataflow",
  async (event) => {
    let success = false;
    const message = event.data.message.json;

    // Some messages have an end_device_ids key and they're those
    // who come from TTN - Nodered - Dataflow
    const hasEndDeviceIdKey = message.end_device_ids !== undefined;

    if (hasEndDeviceIdKey) {
      // Entering here means we are dealing with a message from TTN
      // and can either be pressure message, board_status, tensiometer or
      // sense cap message

      // To know what data we are dealing with, we need to access its content
      // and check the type of messages.

      const decodedPayload = getDecodedPayloadMsg(message);

      const decodedPayloadMsgType = decodedPayload.type;

      // Message type will be undefined when we're dealing with
      // sense cap data
      if (!decodedPayloadMsgType) {
        success = await processSenseCapData(message);
        return Promise.resolve(success);
      }

      logger.info(`Processing message of type: ${decodedPayloadMsgType}`);
      success = await switchBaseOnMessageType(
        decodedPayloadMsgType,
        decodedPayload
      );
    } else {
      const messageType = message.type;
      if (!messageType) {
        throw new Error("Message type is required");
      }
      logger.info(`Processing message of type: ${messageType}`);

      // Call the appropriate function to process the message
      // based on the message type
      success = await switchBaseOnMessageType(messageType, message);
    }

    return Promise.resolve(success);
  }
);

/**
 * A callable function that handles toggling the status of an item
 * Item can be a pump, sector, board, etc.
 *
 */
exports.toggleItemStatus = https.onCall(async (req: CallableRequest) => {
  try {
    const body: HttpCallableReqBody = req.data;

    logger.info(
      `Toggling status of ${body.mqttMsgName} to ${body.message} with topic ${body.topic}`
    );
    const client = await createMqttClient();
    if (client.disconnected) {
      throw new https.HttpsError("internal", "MQTT client is disconnected");
    }

    // Msgs sent to mqtt aren't raw strings, they are objects
    const messageForMqtt: StatusMessage = {
      name: body.mqttMsgName,
      status: body.message,
      type: body.isPump ? "pump_status" : "sector_status",
    };
    const messageBuffer = Buffer.from(JSON.stringify(messageForMqtt));
    client.publish(body.topic, messageBuffer);

    // When dev environment is dev, insert manual data to local db
    if (process.env.NODE_ENV === "dev") {
      await saveDataWhenDev(body);
    }

    return {success: true};
  } catch (error) {
    throw new https.HttpsError("internal", error as string);
  }
});
