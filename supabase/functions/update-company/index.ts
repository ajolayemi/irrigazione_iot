import {commonUpdate} from "../_utils/commonDatabaseOperations.ts";

console.log(`Function "update-company" up and running!`);

Deno.serve(async (req: Request): Promise<Response> => {
  return await commonUpdate(req, "companies");
});
