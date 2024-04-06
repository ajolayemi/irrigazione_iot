import { commonInsert } from "../_utils/commonDatabaseOperations.ts";

console.log(`Function "insert-new-company" up and running!`);

Deno.serve(async (req: Request): Promise<Response> => {
  return await commonInsert(req, "companies");
});
