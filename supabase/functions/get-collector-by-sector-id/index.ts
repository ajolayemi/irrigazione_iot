import {ColumnNames, TableNames} from "../_utils/tableConstants.ts";
import {createEdgeSupabaseClient} from "../_utils/supabaseClient.ts";

console.log(`Function "get-collector-by-sector-id" up and running!`);

/**
 * Get the collector connected to a sector.
 */

Deno.serve(async (req) => {
  try {
    const {sector_id} = await req.json();

    const supabase = createEdgeSupabaseClient(req);

    const {data: result, error} = await supabase
      .from(TableNames.collector_sectors)
      .select("*")
      .eq(ColumnNames.sector_id_as_fkey, sector_id).maybeSingle();

    if (error) throw error;

    return new Response(JSON.stringify({result}), {
      status: 200,
      headers: {"Content-Type": "application/json"},
    });
  } catch (error) {
    console.log(
      `An error occurred in get-collector-by-sector-id: ${error.message}`
    );
    return new Response(JSON.stringify({error: error.message}), {
      status: 400,
      headers: {"Content-Type": "application/json"},
    });
  }
});

/* To invoke locally:

  1. Run `supabase start` (see: https://supabase.com/docs/reference/cli/supabase-start)
  2. Make an HTTP request:

  curl -i --location --request POST 'http://127.0.0.1:54321/functions/v1/get-collector-by-sector-id' \
    --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0' \
    --header 'Content-Type: application/json' \
    --data '{"name":"Functions"}'

*/
