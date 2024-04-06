import {commonInsert} from "../_utils/commonDatabaseOperations.ts";
import {TablesNames} from "../_utils/tablesConstants.ts";

console.log(`Function "insert-new-company-user" up and running!`);

Deno.serve(async (req: Request): Promise<Response> => {
  return await commonInsert(req, TablesNames.companies_user);
});
