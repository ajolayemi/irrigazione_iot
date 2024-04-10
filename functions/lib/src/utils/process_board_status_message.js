"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.processBoardStatusMessage = void 0;
const v1_1 = require("firebase-functions/v1");
const read_board_data_1 = require("../database/boards/read_board_data");
const insert_board_data_1 = require("../database/boards/insert_board_data");
const processBoardStatusMessage = async (message) => {
    try {
        if (!message) {
            throw new Error("Message to process board status is undefined");
        }
        v1_1.logger.info("Processing board status message...");
        const board = await (0, read_board_data_1.getBoardByMqttMsgName)(message.name);
        if (!board) {
            throw new Error(`No board matching the provided ${message.name} was found in database`);
        }
        v1_1.logger.info(`Inserting board status for ${message.name} into database`);
        await (0, insert_board_data_1.insertBoardStatusData)({
            created_at: new Date().toISOString(),
            board_id: board.id,
            battery_level: message.vbat,
        });
        v1_1.logger.info(`Board status for ${message.name} inserted successfully`);
        return true;
    }
    catch (error) {
        v1_1.logger.error(`Error processing board status message: ${error}`);
        return false;
    }
};
exports.processBoardStatusMessage = processBoardStatusMessage;
//# sourceMappingURL=process_board_status_message.js.map