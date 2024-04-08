import {TableNames} from "../_utils/tableConstants.ts";
import {commonInsert} from "../_utils/commonDatabaseOperations.ts";

console.log(`Function "insert-sector" up and running!`);

/**
 * Insert a new sector into the sectors table.
 */
Deno.serve(async (req) => await commonInsert(req, TableNames.sectors));
