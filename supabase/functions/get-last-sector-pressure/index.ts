import {TableNames, ColumnNames} from "../_utils/tableConstants.ts";
import {commonGetLastRecordById} from "../_utils/commonDatabaseOperations.ts";

console.log(`Function "get-last-sector-pressure" up and running!`);

Deno.serve(
  async (req) =>
    await commonGetLastRecordById(
      req,
      TableNames.sector_pressures,
      ColumnNames.sector_id_as_fkey
    )
);
