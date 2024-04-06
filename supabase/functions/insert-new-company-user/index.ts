import {commonInsert} from "../_utils/commonInsert.ts";

console.log(`Function "insert-new-company-user" up and running!`);

Deno.serve(async (req: Request): Promise<Response> => {
  return await commonInsert(req, "companies_user");
});
