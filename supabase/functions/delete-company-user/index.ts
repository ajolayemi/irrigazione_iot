import {commonDelete} from "../_utils/commonDatabaseOperations.ts";
import {TablesNames} from "../_utils/tablesConstants.ts";

console.log(`Function "delete-company-user" up and running!`);

Deno.serve(async (req: Request): Promise<Response> => {
  return await commonDelete(req, TablesNames.companies_user);
});
