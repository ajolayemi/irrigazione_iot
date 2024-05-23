import {logger} from "firebase-functions/v1";
import {BoardStatusMessage} from "../interfaces/interfaces";
import {getBoardByEui} from "../database/boards/read_board_data";
import {insertBoardStatusData} from "../database/boards/insert_board_data";
import {insertDataInSheet} from "./gs_utils";
import {TablesInsert} from "../../schemas/database.types";
import {customFormatDate} from "./helper_funcs";
import {BoardStatusGs} from "../models/board_status_for_gs";
import {getCompanyById} from "../database/companies/read_company_data";

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
      `Inserting board status for ${board.name} into database and google sheet`
    );
    const currentDate = new Date();

    const boardStatus: TablesInsert<"board_statuses"> = {
      created_at: currentDate.toISOString(),
      board_id: board.id,
      battery_level: message.vbat,
    };

    // Insert data to supabase
    await insertBoardStatusData(boardStatus);

    // Get the company this board belongs to
    const company = await getCompanyById(board.company_id.toString());

    const dataForGs = new BoardStatusGs(
      board.id,
      board.name,
      board.company_id,
      company.name,
      message.vbat,
      customFormatDate(currentDate)
    );
    // Insert data to google sheets
    await insertDataInSheet(
      dataForGs.workSheetName,
      dataForGs.getValues()
    );

    logger.info(`Board status for ${board.name} inserted successfully`);
    return true;
  } catch (error) {
    logger.error(`Error processing board status message: ${error}`);
    return false;
  }
};
