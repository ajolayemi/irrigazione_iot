import {commonDelete} from "../_utils/commonDatabaseOperations.ts";
import {TableNames} from "../_utils/tableConstants.ts";

console.log(`Function "delete-company-user" up and running!`);

Deno.serve(async (req: Request): Promise<Response> => {
  return await commonDelete(req, TableNames.company_users);
});
