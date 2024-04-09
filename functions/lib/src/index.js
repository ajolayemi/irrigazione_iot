"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const firebase_admin_1 = require("firebase-admin");
const v2_1 = require("firebase-functions/v2");
const process_pressure_message_1 = require("./utils/process_pressure_message");
firebase_admin_1.default.initializeApp();
exports.processPressureMessages = v2_1.pubsub.onMessagePublished("pressure", async (event) => {
    const message = event.data.message.json;
    const successInProcessingMessage = await (0, process_pressure_message_1.processPressureMessageFromPubSub)(message);
    return Promise.resolve(successInProcessingMessage);
});
//# sourceMappingURL=index.js.map