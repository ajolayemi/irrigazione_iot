import {Database} from "firebase-admin/database";
import {getSecretFromCloud} from "./secrets";
import {SupabaseClient, createClient} from "@supabase/supabase-js";

/**
 * Creates a Supabase client with the provided URL and anon key
 * @return {Promise<SupabaseClient<Database>>} The Supabase client
 */
export const createSupabaseClient = async (): Promise<
  SupabaseClient<Database>
> => {
  const url = await getSecretFromCloud("SUPABASE_URL");
  const anon = await getSecretFromCloud("SUPABASE_ANON_KEY");
  return createClient<Database>(url, anon);
};
