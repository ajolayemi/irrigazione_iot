#!/usr/bin/node
"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.publishMessage = void 0;
const pubsub_1 = require("@google-cloud/pubsub");
const publishMessage = async (topicName, data) => {
    const pubSubClient = new pubsub_1.PubSub();
    const dataBuffer = Buffer.from(data);
    const messageId = await pubSubClient.topic(topicName).publish(dataBuffer);
    console.log(`Message ${messageId} published.`);
};
exports.publishMessage = publishMessage;
//# sourceMappingURL=pub_sub.js.map