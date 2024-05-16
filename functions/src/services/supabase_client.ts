import {Database} from "firebase-admin/database";
import {getSecretFromCloud} from "./secrets";
import {SupabaseClient, createClient} from "@supabase/supabase-js";

import dotenv = require("dotenv");
import {logger} from "firebase-functions/v2";
dotenv.config({path: "../../../.env"});

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
  logger.info(`Supabase URL: ${url}`);
  const anon = await getSecretFromCloud(supabaseKeySecretKey);
  logger.info(`Supabase anon key: ${anon}`);
  return createClient<Database>(url, anon);
};
