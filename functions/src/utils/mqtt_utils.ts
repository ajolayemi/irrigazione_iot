import dotenv = require("dotenv");
dotenv.config({path: "../../../.env"});

/**
 * Helps in building the MQTT topic to post a payload to for
 * usage in flutter base on the provided message type and current environment
 * @param {string} messageType The type of message to process
 * @return {string} The MQTT topic to publish to
 */
export const buildMqttTopic = (messageType: string, companyId: string): string => {
  const env = process.env.NODE_ENV;
  const topic = `${companyId}/flutter/${env?.toLowerCase()}/${messageType}`;
  return topic;
};

