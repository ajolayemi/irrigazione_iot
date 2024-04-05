import {createEdgeSupabaseClient} from "../_utils/supabaseClient.ts";

console.log(`Function "get-companies-by-id" up and running!`);

Deno.serve(async (req) => {
  try {
    const supabaseClient = createEdgeSupabaseClient(req);

    // Get the id provided in the request body
    const {id} = await req.json();


    const {data: company, error} = await supabaseClient
      .from("companies")
      .select("*")
      .eq("id", id as number)
      .maybeSingle();
    if (error) throw error;
    return new Response(JSON.stringify(company), {
      headers: {"Content-Type": "application/json"},
      status: 200,
    });
  } catch (error) {
    console.error(`An error occurred: ${error.message}`);
    return new Response(JSON.stringify({error: error.message}), {
      status: 400,
      headers: {"Content-Type": "application/json"},
    });
  }
});
