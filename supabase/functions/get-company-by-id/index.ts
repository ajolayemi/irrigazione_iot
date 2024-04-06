import {commonGetById} from "../_utils/commonDatabaseOperations.ts";
import {TablesNames} from "../_utils/tablesConstants.ts";

console.log(`Function "get-companies-by-id" up and running!`);

Deno.serve(async (req) => {
  return await commonGetById(req, TablesNames.companies);
});
