import admin from "firebase-admin";
import {logger, pubsub, https} from "firebase-functions/v2";
import {processSenseCapData} from "./database/weather_station/process_sense_cap_data";
import {
  getDecodedPayloadMsg,
  switchBaseOnMessageType,
  switchBaseOnTable,
} from "./utils/helper_funcs";

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
 * A firebase callable function that gets called by supabase webhook
 * when a new record is inserted to tables in the database.
 * The function processes the received data and saves it to google sheets
 */
exports.insertDataInGoogleSheet = https.onRequest(async (req, res) => {
  try {
    const {table, record} = req.body;
    console.log(`Inserting data to google sheet for table: ${table}`);
    console.log(`Data received: ${JSON.stringify(record)}`);
    await switchBaseOnTable(table, record);
    res.status(200).send("Data inserted successfully");
  } catch (error) {
    res.status(500).send(`Error inserting data: ${error}`);
  }
});
