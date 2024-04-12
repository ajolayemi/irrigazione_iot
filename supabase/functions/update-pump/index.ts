import {TableNames} from "../_utils/tableConstants.ts";
import {commonUpdate} from "../_utils/commonDatabaseOperations.ts";

console.log(`Function "update-pump" up and running!`);

Deno.serve(async (req) => await commonUpdate(req, TableNames.pumps));
