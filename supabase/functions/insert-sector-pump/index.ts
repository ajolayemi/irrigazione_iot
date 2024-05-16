import {TableNames} from "../_utils/tableConstants.ts";
import {commonInsert} from "../_utils/commonDatabaseOperations.ts";

console.log(`Function "insert-sector-pump" up and running!`);

/**
 * Insert a new sector pumps into the sector_pumps table.
 */
Deno.serve(async (req) => await commonInsert(req, TableNames.sector_pumps));
