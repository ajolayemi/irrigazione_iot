import {Tables} from "../../../schemas/database.types";
import {createSupabaseClient} from "../../services/supabase_client";

/**
 * References the get-sector-by-mqtt-msg-name Supabase Edge function to get a sector by MQTT message name
 * @param name The MQTT message name of the sector to get
 * @returns The sector with the given MQTT message name if it exists
 */
export const getSectorByMqttMsgName = async (
  name: string
): Promise<Tables<"sectors">> => {
  // Get the Supabase client
  const supabase = await createSupabaseClient();
  // Get the sector by MQTT message name
  const {data, error} = await supabase.functions.invoke(
    "get-sector-by-mqtt-msg-name",
    {
      body: {name},
    }
  );

  if (error) throw error;

  return data["result"] as Tables<"sectors">;
};


/**
 * References the get-collector-by-sector-id Supabase Edge function to get a collector by sector id
 * The underline Edge function access the collector_sectors table to get the collector
 * @param sector_id The sector id to get the collector for
 * @returns 
 */
export const getCollectorBySectorId = async (
  sector_id: string
): Promise<Tables<"collector_sectors">> => {
  const supabase = await createSupabaseClient();
  const {data, error} = await supabase.functions.invoke(
    "get-collector-by-sector-id",
    {
      body: {sector_id},
    }
  );

  if (error) throw error;

  return data["result"] as Tables<"collector_sectors">;
};
