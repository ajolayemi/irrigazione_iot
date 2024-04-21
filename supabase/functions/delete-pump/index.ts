import {TableNames} from "../_utils/tableConstants.ts";
import {commonDelete} from "../_utils/commonDatabaseOperations.ts";

console.log(`Function "delete-pump" up and running!`);

Deno.serve(async (req) => await commonDelete(req, TableNames.pumps));
