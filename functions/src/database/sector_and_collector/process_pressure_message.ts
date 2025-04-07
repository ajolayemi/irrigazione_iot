import {CustomJSON} from "../../interfaces/interfaces";
import {logger} from "firebase-functions/v1";
import {
  getCollectorForSector,
  getPressureMessageKeys,
  processCollectorPressure,
  processSectorPressure,
  processTerminalPressure,
} from "./sector_and_collector_utils";

/**
 * An helper function that helps in processing "pressure" messages sent from
 * the MQTT broker and intercepted by Google PubSub. A typical message looks like this:
 * {"A_CH1":-1.389999986,"B_CH2":-1.399999976,"C_CH3":-1.389999986,
 * "Api_CH4":-1.399999976,"Filter_IN":-1.399999976,"Filter_OUT":-1.399999976, "Final_CH4": -2.569999933,"}
 * @param {CustomJSON} message The message to process
 * @param {boolean} debug A boolean that determines if the function should do some things
 * @return {Promise<boolean>} True if the message was successfully processed, false otherwise
 */
export const processPressureMessageFromPubSub = async (
  message: CustomJSON,
  debug = false
): Promise<boolean> => {
  try {
    const currentDate = new Date();
    if (!message) {
      throw new Error("Message to process is required");
    }
    logger.info("Processing pressure message...");
    logger.info(`With message: ${message.toString()}`);

    // Filter out all necessary keys from the message
    const {
      terminalPressureKey,
      collectorPressureKeys,
      sectorKeys,
      splittedSectorKeys,
    } = getPressureMessageKeys(message);

    // It's expected that at least a single sector key is found in the message
    // If no sector key is found, then the message is invalid
    if (!sectorKeys.length || !splittedSectorKeys.length) {
      throw new Error("No sector key found in the message");
    }

    // Get the collector that holds the sectors in the message
    const collectorId = await getCollectorForSector(splittedSectorKeys);

    console.log("collectorId", collectorId);

    if (!collectorId) {
      throw new Error("No collector found for the sectors in the message");
    }

    // Reaching here means that the message is valid and the collector that holds
    // the sectors in the message has been found
    // We can now proceed to process the message
    if (!debug) {
      // First, call on the function that handles the terminal pressure message processing
      await processTerminalPressure(
        terminalPressureKey,
        message,
        collectorId,
        currentDate
      );
      // Next, call on the function that handles the collector pressure message processing
      await processCollectorPressure(
        collectorPressureKeys,
        message,
        collectorId,
        currentDate
      );
      // Finally, call on the function that handles the sector pressure message processing
      await processSectorPressure(sectorKeys, message, currentDate);
    }
    return Promise.resolve(true);
  } catch (error) {
    throw new Error(`Error processing pressure message: ${error}`);
  }
};
