import {logger} from "firebase-functions/v1";
import {BoardStatusMessage} from "../../interfaces/interfaces";
import {getBoardByEui, getBoardById} from "./read_board_data";
import {insertBoardStatusData} from "./insert_board_data";
import {insertDataInSheet} from "../../utils/gs_utils";
import {TablesInsert} from "../../../schemas/database.types";
import {customFormatDate} from "../../utils/helper_funcs";
import {BoardStatusGs} from "../../models/board_status_for_gs";
import {getCompanyById} from "../companies/read_company_data";

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

    logger.info(
      `Inserting board status for ${board.name} into database`
    );
    const currentDate = new Date();

    const boardStatus: TablesInsert<"board_statuses"> = {
      created_at: currentDate.toISOString(),
      board_id: board.id,
      battery_level: message.vbat,
    };

    // Insert data to supabase
    await insertBoardStatusData(boardStatus);

    logger.info(`Board status for ${board.name} inserted successfully`);
    return true;
  } catch (error) {
    logger.error(`Error processing board status message: ${error}`);
    return false;
  }
};

/**
 * Processes board status messages for google sheet
 * @param {TablesInsert<"board_statuses">} data The data to process
 * @return {Promise<boolean>} A promise that resolves to true if the data was processed successfully
 */
export const processBoardStatusMessageForGs = async (
  data: TablesInsert<"board_statuses">
): Promise<boolean> => {
  if (!data) {
    throw new Error(
      "No data provided to process board status message for google sheet"
    );
  }
  console.log("Processing board status message for google sheet with data: ");
  console.log(data);
  try {
    const board = await getBoardById(data.board_id.toString());
    // Get the company this board belongs to
    const company = await getCompanyById(board.company_id.toString());

    // TODO: the
    const timestamp = new Date(data.created_at || new Date());

    const dataForGs = new BoardStatusGs(
      board.id,
      board.name,
      board.company_id,
      company.name,
      data.battery_level,
      customFormatDate(timestamp)
    );
    // Insert data to google sheets
    await insertDataInSheet(BoardStatusGs.workSheetName, dataForGs.getValues());
    return Promise.resolve(true);
  } catch (error) {
    throw new Error(
      `Error processing board status message for google sheet: ${error}`
    );
  }
};
