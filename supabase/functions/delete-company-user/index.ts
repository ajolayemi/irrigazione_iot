import {commonDelete} from "../_utils/commonDatabaseOperations.ts";

console.log(`Function "delete-company-user" up and running!`);

Deno.serve(async (req: Request): Promise<Response> => {
  return await commonDelete(req, "companies_user");
});
