import {Tables} from "../../../schemas/database.types";
import {createSupabaseClient} from "../../services/supabase_client";

/**
 * References the get-pump-by-id Supabase Edge function to get a pump by id
 * @param {string} id The id of the pump to get
 * @return {Promise<Tables<"pumps">>} The pump with the given id
 */
export const getPumpById = async (id: string): Promise<Tables<"pumps">> => {
  // Get the Supabase client
  const supabase = await createSupabaseClient();
  // Get the pump by id
  const {data, error} = await supabase.functions.invoke("get-pump-by-id", {
    body: {id},
  });

  if (error) {
    throw error;
  }

  return data["result"] as Tables<"pumps">;
};

/**
 * References the get-pump-by-mqtt-msg-name Supabase Edge function to get a pump by
 * MQTT message name
 * @param  {string} name The MQTT message name of the pump to get
 * @return {Promise<Tables<"pumps">>} The pump with the given MQTT message name
 */
export const getPumpByMqttMsgName = async (
  name: string
): Promise<Tables<"pumps">> => {
  // Get the Supabase client
  const supabase = await createSupabaseClient();
  // Get the pump by MQTT message name
  const {data, error} = await supabase.functions.invoke(
    "get-pump-by-mqtt-msg-name",
    {
      body: {name},
    }
  );

  if (error) {
    throw error;
  }

  return data["result"] as Tables<"pumps">;
};
