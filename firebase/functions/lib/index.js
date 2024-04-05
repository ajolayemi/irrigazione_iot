"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const firebase_admin_1 = require("firebase-admin");
(0, firebase_admin_1.initializeApp)();
// exports.processPressureMessages = pubsub.onMessagePublished(
//   "pressure",
//   async (event) => {
//     return;
//     // const message = event.data.message;
//     // console.log("I was called");
//     // const data = Buffer.from(message.data, "base64").toString();
//     // logger.info(`Received message: ${JSON.stringify(data)}`);
//     // return Promise.resolve();
//   }
// );
exports.processPressureMessages = () => console.log("I was called");
//# sourceMappingURL=index.js.map