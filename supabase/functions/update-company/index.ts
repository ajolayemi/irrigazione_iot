import {commonUpdate} from "../_utils/commonDatabaseOperations.ts";
import {TablesNames} from "../_utils/tablesConstants.ts";

console.log(`Function "update-company" up and running!`);

Deno.serve(async (req: Request): Promise<Response> => {
  return await commonUpdate(req, TablesNames.companies);
});
