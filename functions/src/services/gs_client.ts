import {google, sheets_v4 as SheetsV4} from "googleapis";

/**
 * Handles the logic behind spreadsheet authorization
 * @return {SheetsV4.Sheets} The loaded spreadsheet
 */
export const getSpreadsheets = (): SheetsV4.Sheets => {
  const auth = new google.auth.GoogleAuth({
    scopes: ["https://www.googleapis.com/auth/spreadsheets"],
  });
  const options: SheetsV4.Options = {auth: auth, version: "v4"};
  return google.sheets(options);
};
