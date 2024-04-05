import { createEdgeSupabaseClient } from "../_utils/supabaseClient.ts";

console.log(`Function "update-company" up and running!`);

Deno.serve(async (req: Request): Promise<Response> => {
  try {
    const supabaseClient = createEdgeSupabaseClient(req);

    // Get the company data provided in the request body
    const {toUpdate} = await req.json();

    // Update the company
    const {data, error} = await supabaseClient.from("companies").update(toUpdate).eq("id", toUpdate.id).select();
    
    if (error) throw error;

    return new Response(
      JSON.stringify(data),
      {
        headers: {"Content-Type": "application/json"},
        status: 200,
      }
    );
  } catch (error) {
    console.error(`An error occurred in update-company: ${error.message}`);
    return new Response(JSON.stringify({error: error.message}), {
      status: 400,
      headers: {"Content-Type": "application/json"},
    });
  }
});