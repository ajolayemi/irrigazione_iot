import dotenv = require("dotenv");
import {connect, MqttClient} from "mqtt";
import {getSecretFromCloud} from "./secrets";
import {logger} from "firebase-functions/v2";
dotenv.config({path: "../../../.env"});

/**
 * Creates a MQTT client with the provided URL
 * and port
 * @return {Promise<MqttClient>} The MQTT client
 */
export const createMqttClient = async (): Promise<MqttClient> => {
  const env = process.env.NODE_ENV;
  const mqttUrlSecretKey = `mqtt-url-${env}`;

  const mqttUsernameSecretKey = `mqtt-username-${env}`;
  const mqttPasswordSecretKey = `mqtt-password-${env}`;

  const mqttUsername = await getSecretFromCloud(mqttUsernameSecretKey);
  const mqttPassword = await getSecretFromCloud(mqttPasswordSecretKey);
  const mqttUrl = await getSecretFromCloud(mqttUrlSecretKey);

  const client = connect(mqttUrl, {
    port: 1883,
    username: mqttUsername,
    password: mqttPassword,
  });

  client.on("error", (error) => {
    logger.error("MQTT client failed to connect:", error);
  });

  return client.on("connect", () => {
    logger.info("MQTT client connected successfully");
    return client;
  });
};

/**
 * Disconnects the MQTT client
 * @param {MqttClient} client The MQTT client to disconnect
 */
export const disconnectMqttClient = (client: MqttClient): void => {
  client.end(true, () => {
    console.log("MQTT client disconnected");
  });
};

/**
 * Handles message publishing to the MQTT client
 * @param {string} topic The topic to publish to
 * @param {any} message The message to publish
 * @return {Promise<void>} A promise that resolves when the message is published
 */
export const publishMessageToMqtt = async (
  topic: string,
  message: any,
): Promise<void> => {
  try {
    const client = await createMqttClient();
    client.on("connect", () => {
      logger.info(`Publishing message to MQTT client with topic: ${topic}`);
      client.publish(topic, JSON.stringify(message), (error) => {
        if (error) {
          logger.error("Failed to publish message:", error);
        } else {
          logger.info(`Message published to topic ${topic}`);
        }
      });
    });
    return;
  } catch (error) {
    logger.error("Error publishing message to MQTT client:", error);
    return;
  }
};
