import {sheets_v4 as SheetsV4} from "googleapis";
import {getSpreadsheets} from "../services/gs_client";
import {logger} from "firebase-functions/v2";
import {getSecretFromCloud} from "../services/secrets";
import {EnvVariables} from "../services/env_variables";


/**
 * A wrapper around google sheet api func to insert new values to google sheet
 * @param {string} worksheetName The name of the worksheet where the insertion
 * should be done
 * @param {any[][]} dataToInsert The new values
 * @return {Promise<SheetsV4.Schema$UpdateValuesResponse | null>}
 * The result of the insert request if it was successful or a null value
 */
export const insertDataInSheet = async (
  worksheetName: string,
  dataToInsert: any[][]
): Promise<SheetsV4.Schema$AppendValuesResponse | null> => {
  try {
    const sheets = getSpreadsheets();
    // Access cloud secrets to get the spreadsheet id
    const nodeEnv = EnvVariables.NODE_ENV;
    const sheetIdKey = `gs-id-${nodeEnv}`;

    const spreadsheetId = await getSecretFromCloud(sheetIdKey);

    const insertResponse = await sheets.spreadsheets.values.append({
      spreadsheetId: spreadsheetId,
      range: worksheetName,
      valueInputOption: "USER_ENTERED",
      requestBody: {
        values: dataToInsert,
      },
    });

    if (insertResponse.status == 200) {
      const responseData = insertResponse.data;
      logger.info(`Insert request done successfully: ${responseData.updates}`);
      return responseData;
    }
    logger.error(`The request to insert data in worksheet: ${worksheetName} 
      with provided values ${dataToInsert} failed with status
      ${insertResponse.statusText}`);
    return null;
  } catch (error) {
    logger.error(`${error} occurred while 
      trying to insert data in worksheet: ${worksheetName} 
      with provided values ${dataToInsert}`);
    return null;
  }
};
