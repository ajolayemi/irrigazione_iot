import {connect, MqttClient} from "mqtt";
import {getSecretFromCloud} from "./secrets";

import dotenv = require("dotenv");
dotenv.config({path: "../../../.env"});

/**
 * Create a new MQTT client
 * @return {Promise<MqttClient>} The new MQTT client
 */
export const createMqttClient = async (): Promise<MqttClient> => {
  const nodeEnv = process.env.NODE_ENV;
  const urlKey = `mqtt-url-${nodeEnv}`;
  const passwordKey = `mqtt-password-${nodeEnv}`;
  const usernameKey = `mqtt-username-${nodeEnv}`;

  const mqttUrl = await getSecretFromCloud(urlKey);
  const mqttUsername = await getSecretFromCloud(usernameKey);
  const mqttPassword = await getSecretFromCloud(passwordKey);
  return connect(mqttUrl, {
    username: mqttUsername,
    password: mqttPassword,
  });
};

/**
 * Publish a message to an MQTT topic
 * @param {MqttClient} client The MQTT client to use
 * @param {string} topic The topic to publish to
 * @param {string} message The message to publish
 * @return {boolean} Whether the message was published successfully
 */
export const publishMqttMessage = (
  client: MqttClient,
  topic: string,
  message: string
): boolean => {
  let success = false;
  client.publish(topic, message, (err) => {
    if (err) {
      console.error(`Failed to publish message to ${topic}: ${err}`);
      return;
    }
    console.log(`Published message to ${topic}`);
    success = true;
    return;
  });
  return success;
};
