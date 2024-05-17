import {logger} from "firebase-functions/v1";
import {BoardStatusMessage} from "../interfaces/interfaces";
import {getBoardByEui} from "../database/boards/read_board_data";
import {insertBoardStatusData} from "../database/boards/insert_board_data";

export const processBoardStatusMessage = async (
  message: BoardStatusMessage
): Promise<boolean> => {
  try {
    if (!message) {
      throw new Error("Message to process board status is undefined");
    }

    logger.info("Processing board status message...");

    const board = await getBoardByEui(message.eui);

    if (!board) {
      throw new Error(
        `No board matching the provided ${message.eui} was found in database`
      );
    }

    logger.info(`Inserting board status for ${board.name} into database`);
    await insertBoardStatusData({
      created_at: new Date().toISOString(),
      board_id: board.id,
      battery_level: message.vbat,
    });
    logger.info(`Board status for ${board.name} inserted successfully`);
    return true;
  } catch (error) {
    logger.error(`Error processing board status message: ${error}`);
    return false;
  }
};
