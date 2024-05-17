import admin from "firebase-admin";
import {https, logger, pubsub} from "firebase-functions/v2";
import "dotenv/config";
// import {processPressureMessageFromPubSub} from "./utils/process_pressure_message";
// import {processSectorStatusMessage} from "./utils/process_sector_status_message";
// import {processPumpStatusMessage} from "./utils/process_pump_status_message";
// import {processPumpFlowMessage} from "./utils/process_pump_flow_message";
// import {processPumpPressureMessage} from "./utils/process_pump_pressure_message";
// import {processBoardStatusMessage} from "./utils/process_board_status_message";
import {CallableRequest} from "firebase-functions/v2/https";
import {createMqttClient} from "./services/mqtt";
import {HttpCallableReqBody, StatusMessage} from "./interfaces/interfaces";
// import {processSenseCapData} from "./utils/process_sense_cap_data";
import {saveDataWhenDev} from "./utils/save_dev_data";
import {processPressureMessageFromPubSub} from "./utils/process_pressure_message";
import {processSectorStatusMessage} from "./utils/process_sector_status_message";
import {processPumpStatusMessage} from "./utils/process_pump_status_message";
import {processPumpFlowMessage} from "./utils/process_pump_flow_message";
import {processPumpPressureMessage} from "./utils/process_pump_pressure_message";
import {processBoardStatusMessage} from "./utils/process_board_status_message";
import {processSenseCapData} from "./utils/process_sense_cap_data";

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

    // Messages for weather stations coming from TTN has an end_device_ids key
    // If the key is present, it means the message is from a weather station
    // and should be processed differently
    const hasEndDeviceIdKey = message.end_device_ids !== undefined;

    if (hasEndDeviceIdKey) {
      success = await processSenseCapData(message);
      return Promise.resolve(success);
    }
    const messageType = message.type;
    if (!messageType) {
      throw new Error("Message type is required");
    }
    logger.info(`Processing message of type: ${messageType}`);

    // Call the appropriate function to process the message
    // based on the message type
    switch (messageType) {
      case "pressure":
        success = await processPressureMessageFromPubSub(message);
        break;
      case "sector_status":
        success = await processSectorStatusMessage(message);
        break;
      case "pump_status":
        success = await processPumpStatusMessage(message);
        break;
      case "pump_flow":
        success = await processPumpFlowMessage(message);
        break;
      case "pump_pressure":
        success = await processPumpPressureMessage(message);
        break;
      case "board_status":
        success = await processBoardStatusMessage(message);
        break;
      default:
        throw new Error("Invalid message type");
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
