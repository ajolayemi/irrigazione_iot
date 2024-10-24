import {commonInsert} from "../_utils/commonDatabaseOperations.ts";
import {TableNames} from "../_utils/tableConstants.ts";

console.log(`Function "insert-company" up and running!`);

Deno.serve(async (req: Request): Promise<Response> => {
  return await commonInsert(req, TableNames.companies, false);
});
