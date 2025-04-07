import {corsHeaders} from "../_utils/cors.ts";
import {createEdgeSupabaseClient} from "../_utils/supabaseClient.ts";
import {TableNames} from "../_utils/tableConstants.ts";

console.log(`Function invoked: query-weather-station-referenced-tables`);

/**
 * Queries weather station table and its references tables
 * which are sector and company tables
 */
Deno.serve(async (req): Promise<Response> => {
  // This is needed if you're planning to invoke your function from a browser.
  if (req.method === "OPTIONS") {
    return new Response("ok", {headers: corsHeaders});
  }
  try {
    const supabaseClient = createEdgeSupabaseClient(req);

    // Get the id provided in the request body
    const {id} = await req.json();

    // Get the record

    const {data: weather_stations, error} = await supabaseClient
      .from(TableNames.weatherStations)
      .select(
        `
      id, name, eui,
      ${TableNames.sectors} (
        id,
        name
      ),
     ${TableNames.companies} (
        id, name
      )
    `
      )
      .eq("id", id);

    if (error) throw error;

    return new Response(JSON.stringify({weather_stations}), {
      headers: {"Content-Type": "application/json"},
      status: 200,
    });
  } catch (error) {
    console.error(
      `An error occurred when querying weather station table: ${error.message}`
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

  curl -i --location --request POST 'http://127.0.0.1:54321/functions/v1/query-weather-station-referenced-tables' \
    --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0' \
    --header 'Content-Type: application/json' \
    --data '{"name":"Functions"}'

*/
