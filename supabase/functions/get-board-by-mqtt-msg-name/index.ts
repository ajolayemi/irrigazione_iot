import {TableNames} from "../_utils/tableConstants.ts";
import {commonGetByMqttMsgName} from "../_utils/commonDatabaseOperations.ts";

console.log(`Function 'get-board-by-mqtt-msg-name' invoked`);

Deno.serve(
  async (req) =>
    await commonGetByMqttMsgName(req, TableNames.boards, "id, company_id, collector_id")
);

/* To invoke locally:

  1. Run `supabase start` (see: https://supabase.com/docs/reference/cli/supabase-start)
  2. Make an HTTP request:

  curl -i --location --request POST 'http://127.0.0.1:54321/functions/v1/get-board-by-mqtt-msg-name' \
    --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0' \
    --header 'Content-Type: application/json' \
    --data '{"name":"Functions"}'

*/
