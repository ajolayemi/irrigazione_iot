import {createEdgeSupabaseClient} from "../_utils/supabaseClient.ts";

console.log(`Function "insert-new-company-user" up and running!`);

Deno.serve(async (req: Request): Promise<Response> => {
  try {
    const supabaseClient = createEdgeSupabaseClient(req);

    // Get the company data provided in the request body
    const {data} = await req.json();

    // Insert the new company
    const {error} = await supabaseClient.from("companies_user").insert(data);
    if (error) throw error;
    return new Response(
      JSON.stringify({message: "Company user inserted successfully!"}),
      {
        headers: {"Content-Type": "application/json"},
        status: 200,
      }
    );
  } catch (error) {
    console.error(`An error occurred in insert-new-company-user: ${error.message}`);
    return new Response(JSON.stringify({error: error.message}), {
      status: 400,
      headers: {"Content-Type": "application/json"},
    });
  }
});