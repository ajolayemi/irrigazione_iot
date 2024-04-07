import {commonGetById} from "../_utils/commonDatabaseOperations.ts";
import {TableNames} from "../_utils/tableConstants.ts";

console.log(`Function "get-sector-by-id" up and running!`);

Deno.serve(async (req) => await commonGetById(req, TableNames.sectors));
