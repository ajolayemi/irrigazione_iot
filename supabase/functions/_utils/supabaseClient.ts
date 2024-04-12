import { createClient } from "https://esm.sh/@supabase/supabase-js@2.42.0";

/**
 * Returns a Supabase client with the Auth context of the logged in user
 * to be used in supabase Edge Functions
 * @param req A request object
 * @returns A Supabase client
 */
export const createEdgeSupabaseClient = (req: Request) => {
    const supabaseUrl = Deno.env.get("SUPABASE_URL");
    const supabaseAnonKey = Deno.env.get("SUPABASE_ANON_KEY");
    const authHeaders = req.headers;
    return createClient(
        supabaseUrl ?? "",
        supabaseAnonKey ?? "",
        {
            global: {
                headers: {
                    Authorization: authHeaders.get("Authorization")!,
                },
            },
        }
    );
}