import {commonGetById} from "../_utils/commonDatabaseOperations.ts";
import {TableNames} from "../_utils/tableConstants.ts";

console.log(`Function "get-companies-by-id" up and running!`);

Deno.serve(async (req) => {
  return await commonGetById(req, TableNames.companies);
});
