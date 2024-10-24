import {commonUpdate} from "../_utils/commonDatabaseOperations.ts";
import {TableNames} from "../_utils/tableConstants.ts";

console.log(`Function "update-company" up and running!`);

Deno.serve(async (req: Request): Promise<Response> => {
  return await commonUpdate(req, TableNames.companies);
});
