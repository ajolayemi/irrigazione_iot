import {TableNames} from "../_utils/tableConstants.ts";
import {commonInsert} from "../_utils/commonDatabaseOperations.ts";

console.log(`Function "insert-sector-status" up and running!`);

/**
 * Insert a new sector status into the sector_statuses table.
 */
Deno.serve(async (req) => await commonInsert(req, TableNames.sector_statuses));
