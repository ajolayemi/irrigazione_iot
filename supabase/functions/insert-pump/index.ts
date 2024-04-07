import {commonInsert} from "../_utils/commonDatabaseOperations.ts";
import {TableNames} from "../_utils/tableConstants.ts";

console.log(`Function "insert-pump" up and running!`);

Deno.serve(async (req) => await commonInsert(req, TableNames.pumps));
