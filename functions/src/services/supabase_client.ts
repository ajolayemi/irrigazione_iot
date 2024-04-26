import {Database} from "firebase-admin/database";
import {getSecretFromCloud} from "./secrets";
import {SupabaseClient, createClient} from "@supabase/supabase-js";

require('dotenv').config({ path: '../../../.env' });

/**
 * Creates a Supabase client with the provided URL and anon key
 * @return {Promise<SupabaseClient<Database>>} The Supabase client
 */
export const createSupabaseClient = async (): Promise<
  SupabaseClient<Database>
> => {
  const env = process.env.NODE_ENV;
  const urlSecretKey = `supabase-url-${env}`;
  const supabaseKeySecretKey = `supabase-key-${env}`;
  const url = await getSecretFromCloud(urlSecretKey);
  const anon = await getSecretFromCloud(supabaseKeySecretKey);
  return createClient<Database>(url, anon);
};
