import {createEdgeSupabaseClient} from "../_utils/supabaseClient.ts";

console.log(`Function "update-company-user" up and running!`);

Deno.serve(async (req: Request): Promise<Response> => {
  try {
    const supabaseClient = createEdgeSupabaseClient(req);

    // Get the company-user data provided in the request body
    const {toUpdate} = await req.json();

    // Insert the new company-user
    const {data, error} = await supabaseClient.from("companies_user").update(toUpdate).eq("id", toUpdate.id).select();
    if (error) throw error;
    return new Response(
      JSON.stringify({data}),
      {
        headers: {"Content-Type": "application/json"},
        status: 200,
      }
    );
  } catch (error) {
    console.error(`An error occurred in update-company-user: ${error.message}`);
    return new Response(JSON.stringify({error: error.message}), {
      status: 400,
      headers: {"Content-Type": "application/json"},
    });
  }
});