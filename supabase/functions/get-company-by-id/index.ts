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

    console.log
    
    // Get the id provided in the request body
    const {id} = await req.json();
    console.log(`ID: ${id}`);

    // Get the company by ID
    
    const data = {
      message: `Hello from this outer world to ${id}!`,
    };

    return new Response(JSON.stringify(data), {
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

/* To invoke locally:

  1. Run `supabase start` (see: https://supabase.com/docs/reference/cli/supabase-start)
  2. Make an HTTP request:

  curl -i --location --request POST 'http://127.0.0.1:54321/functions/v1/get-company-by-id' \
    --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0' \
    --header 'Content-Type: application/json' \
    --data '{"name":"Functions"}'

*/
