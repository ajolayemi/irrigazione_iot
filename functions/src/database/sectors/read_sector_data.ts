import {Tables} from "../../../schemas/database.types";
import {createSupabaseClient} from "../../services/supabase_client";

/**
 * References the get-sector-by-mqtt-msg-name Supabase Edge function to get a sector by
 * MQTT message name
 * @param {string} name The MQTT message name of the sector to get
 * @return {Promise<Tables<"sectors">>} The sector with the given MQTT message name if it exists
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
 * References the get-collector-by-sector-id Supabase Edge function
 * to get a collector sector by sector id
 * The underline Edge function access the collector_sectors table to get the collector
 * @param {string} sectorId The sector id to get the collector for
 * @return {Promise<Tables<"collector_sectors">>} The collector sector with the given sector id
 */
export const getCollectorBySectorId = async (
  sectorId: string
): Promise<Tables<"collector_sectors">> => {
  const supabase = await createSupabaseClient();
  const {data, error} = await supabase.functions.invoke(
    "get-collector-by-sector-id",
    {
      body: {sector_id: sectorId},
    }
  );

  if (error) throw error;

  return data["result"] as Tables<"collector_sectors">;
};
