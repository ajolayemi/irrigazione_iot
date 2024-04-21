import {createEdgeSupabaseClient} from "../_utils/supabaseClient.ts";
import {TableNames, ColumnNames} from "../_utils/tableConstants.ts";

console.log(`Function "get-sector-pumps" up and running!`);

/**
 * Get all pumps connected to a sector.
 */
Deno.serve(async (req) => {
  try {
    const {sector_id} = await req.json();

    const supabase = createEdgeSupabaseClient(req);

    const {data, error} = await supabase
      .from(TableNames.sector_pumps)
      .select(`${TableNames.pumps}(*)`)
      .eq(ColumnNames.sector_id_as_fkey, sector_id);

    if (error) throw error;

    return new Response(JSON.stringify(data), {
      status: 200,
      headers: {"Content-Type": "application/json"},
    });
  } catch (error) {
    console.log(`An error occurred in get-sector-pumps: ${error.message}`);
    return new Response(JSON.stringify({error: error.message}), {
      status: 400,
      headers: {"Content-Type": "application/json"},
    });
  }
});
