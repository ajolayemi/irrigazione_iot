import {TableNames} from "../_utils/tableConstants.ts";
import {commonInsert} from "../_utils/commonDatabaseOperations.ts";

console.log(`Function "insert-pump-pressure" up and running!`);

Deno.serve(async (req) => await commonInsert(req, TableNames.pump_pressures));