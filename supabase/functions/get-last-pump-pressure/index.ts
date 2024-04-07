import {TableNames, ColumnNames} from "../_utils/tableConstants.ts";
import {commonGetLastRecordById} from "../_utils/commonDatabaseOperations.ts";

console.log(`Function "get-last-pump-pressure" up and running!`);

Deno.serve(
  async (req) =>
    await commonGetLastRecordById(
      req,
      TableNames.pump_pressures,
      ColumnNames.pump_id_as_fkey
    )
);
