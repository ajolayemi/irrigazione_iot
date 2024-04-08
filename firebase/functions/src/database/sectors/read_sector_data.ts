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
