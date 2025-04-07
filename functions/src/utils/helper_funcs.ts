import {logger} from "firebase-functions/v2";
import {processPressureMessageFromPubSub} from "../database/sector_and_collector/process_pressure_message";
import {
  processSectorStatusMessage,
  processSectorStatusMessageForGs,
} from "../database/sectors/process_sector_status_message";
import {
  processBoardStatusMessage,
  processBoardStatusMessageForGs,
} from "../database/boards/process_board_status_message";
import {
  processPumpPressureDataForGs,
  processPumpPressureMessage,
} from "../database/pumps/process_pump_pressure_message";
import {
  processPumpFlowDataForGs,
  processPumpFlowMessage,
} from "../database/pumps/process_pump_flow_message";
import {
  processPumpStatusDataForGs,
  processPumpStatusMessage,
} from "../database/pumps/process_pump_status_message";
import {
  processCollectorPressureDataForGs,
  processSectorPressureDataForGs,
  processTerminalPressureDataForGs,
} from "../database/sector_and_collector/sector_and_collector_utils_for_gs";
import {
  processSenseCapBatteryDataForGs,
  processSenseCapSensorDataForGs,
} from "../database/weather_station/process_sense_cap_data_for_gs";

// TODO: this function should take in date as string and handle the conversion
// TODO: to a date object
/**
 * Helps in formatting date to a custom format
 * for google sheets insertion. The format is
 * YYYY-MM-DD HH:MM:SS
 * @param {string} dateString The date string to format
 * @return {string} The formatted date
 */
export const customFormatDate = (dateString?: string): string => {
  const toDateObj = new Date(dateString ?? new Date());
  const dateSection = toDateObj.toISOString().split("T")[0];
  const timeSection = toDateObj.toISOString().split("T")[1].split(".")[0];
  return `${dateSection} ${timeSection}`;
};

/**
 * Gets the decoded payload message from the provided data
 * @param {any} data The data to get decoded payload from, typically a JSON object
 * @param {boolean} isFromSenseCap Whether the data is from a SenseCAP device
 * @return {any} The decoded payload
 */
export const getDecodedPayloadMsg = (
  data: any,
  isFromSenseCap = false
): any => {
  // Get the uplink message from the provided data
  const uplinkMessage = data.uplink_message;
  if (!uplinkMessage) {
    logger.error("Aborting, no uplink_message key found in the result");
    throw new Error("No uplink_message key found in the result");
  }

  // Get the decoded payload from the uplink message
  const decodedPayload = uplinkMessage.decoded_payload;
  if (!decodedPayload) {
    logger.error(
      "Aborting, no decoded_payload key found in the uplink_message"
    );
    throw new Error("No decoded_payload key found in the uplink_message");
  }

  if (isFromSenseCap) {
    // Check if the decoded payload is valid
    if (!decodedPayload.valid) {
      logger.error("Aborting, the decoded payload is not valid");
      throw new Error("The decoded payload is not valid");
    }

    // Access the message from the decoded payload
    const message = decodedPayload.messages;

    if (!message) {
      logger.error("Aborting, no message key found in the decoded payload");
      throw new Error("No message key found in the decoded payload");
    }

    return message;
  }

  console.log("Decoded payload: ", decodedPayload);
  return decodedPayload;
};

/**
 * Helps to switch between different message types
 * and call the appropriate function
 * @param {string} messageType The type of message to process
 * @param {any} message The message to process
 * @return {Promise<boolean>} A promise that resolves to true if the message was processed successfully
 */
export const switchBaseOnMessageType = async (
  messageType: string,
  message: any
): Promise<boolean> => {
  switch (messageType) {
  case "pressure":
    return await processPressureMessageFromPubSub(message);

  case "sector_status":
    return await processSectorStatusMessage(message);

  case "pump_status":
    return await processPumpStatusMessage(message);

  case "pump_flow":
    return await processPumpFlowMessage(message);

  case "pump_pressure":
    return await processPumpPressureMessage(message);

  case "board_status":
    return await processBoardStatusMessage(message);

  default:
    throw new Error("Invalid message type");
  }
};

/**
 * Helps in choosing what function to call base on table name when the function to
 * insert data in google sheet is called
 * @param {string} table The table name to process
 * @param {any} record The record to process
 */
export const switchBaseOnTable = async (table: string, record: any) => {
  switch (table) {
  case "sector_statuses":
    return await processSectorStatusMessageForGs(record);

  case "board_statuses":
    return await processBoardStatusMessageForGs(record);

  case "terminal_pressures":
    return await processTerminalPressureDataForGs(record);

  case "sector_pressures":
    return await processSectorPressureDataForGs(record);

  case "collector_pressures":
    return await processCollectorPressureDataForGs(record);

  case "pump_flows":
    return await processPumpFlowDataForGs(record);

  case "pump_pressures":
    return await processPumpPressureDataForGs(record);

  case "pump_statuses":
    return await processPumpStatusDataForGs(record);

  case "weather_station_battery_data":
    return await processSenseCapBatteryDataForGs(record);

  case "weather_station_measurements":
    return await processSenseCapSensorDataForGs(record);

  default:
    throw new Error("Invalid table name");
  }
};
