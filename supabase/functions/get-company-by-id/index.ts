import {createClient} from "https://esm.sh/@supabase/supabase-js@2.42.0";

console.log(`Function "get-companies-by-id" up and running!`);

Deno.serve(async (req) => {
  const authHeaders = req.headers;

  try {
    const supabaseUrl = Deno.env.get("SUPABASE_URL");
    // console.log(`Supabase url from deno env: ${supabaseUrl}`);

    const supabaseAnonKey = Deno.env.get("SUPABASE_ANON_KEY");
    // console.log(`Supabase anon key from deno env: ${supabaseAnonKey}`);

    // Create a Supabase client with the Auth context of the logged in user
    const supabaseClient = createClient(
      supabaseUrl ?? "",
      supabaseAnonKey ?? "",
      // Create a global Auth context of the user that called the function
      // This allows the RLS policies to be applied correctly
      {
        global: {
          headers: {
            Authorization: authHeaders.get("Authorization")!,
          },
        },
      }
    );

    // Get the id provided in the request body
    const {id} = await req.json();


    const {data: company, error} = await supabaseClient
      .from("companies")
      .select("*")
      .eq("id", id as number).maybeSingle();
    if (error) throw error;
    return new Response(JSON.stringify(company), {
      headers: {"Content-Type": "application/json"},
    });
  } catch (error) {
    console.error(`An error occurred: ${error.message}`);
    return new Response(JSON.stringify({error: error.message}), {
      status: 400,
      headers: {"Content-Type": "application/json"},
    });
  }
});
