import {TableNames} from "../_utils/tableConstants.ts";
import {commonInsert} from "../_utils/commonDatabaseOperations.ts";

console.log(`Function "insert-sector-pressure" up and running!`);

/**
 * Insert a new sector pressure into the sector_pressures table.
 */
Deno.serve(async (req) => await commonInsert(req, TableNames.sector_pressures));
