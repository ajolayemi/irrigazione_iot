import { createEdgeSupabaseClient } from "../_utils/supabaseClient.ts";

console.log(`Function "delete-company" up and running!`);

Deno.serve(async (req: Request): Promise<Response> => {
  try {
    const supabaseClient = createEdgeSupabaseClient(req);

    // Get the company id provided in the request body
    const {id} = await req.json();

    // Delete the company
    const {error} = await supabaseClient.from("companies").delete().match({id});
    if (error) throw error;
    return new Response(
      JSON.stringify({message: "Company deleted successfully!"}),
      {
        headers: {"Content-Type": "application/json"},
        status: 200,
      }
    );
  } catch (error) {
    console.error(`An error occurred in delete-company: ${error.message}`);
    return new Response(JSON.stringify({error: error.message}), {
      status: 400,
      headers: {"Content-Type": "application/json"},
    });
  }
});