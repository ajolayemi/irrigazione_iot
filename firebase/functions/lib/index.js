"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const v1_1 = require("firebase-functions/v1");
const logger = require("firebase-functions/logger");
exports.processPressureMessages = v1_1.pubsub.topic('pressure').onPublish((message) => {
    logger.info(`Received message: ${message.json}`);
    return Promise.resolve();
});
//# sourceMappingURL=index.js.map