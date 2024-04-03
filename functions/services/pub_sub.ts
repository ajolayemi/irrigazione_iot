#!/usr/bin/node
import {PubSub} from "@google-cloud/pubsub";

export const publishMessage = async (topicName: string, data: string) => {
  const pubSubClient = new PubSub();
  const dataBuffer = Buffer.from(data);
  const messageId = await pubSubClient.topic(topicName).publish(dataBuffer);
  console.log(`Message ${messageId} published.`);
};
