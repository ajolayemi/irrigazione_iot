import {Tables} from "../../../schemas/database.types";
import {createSupabaseClient} from "../../services/supabase_client";

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

  return data as Tables<"pumps">;
};

export const getPumpByMqttMsgName = async (name: string): Promise<Tables<"pumps">> => {
  // Get the Supabase client
  const supabase = await createSupabaseClient();
  // Get the pump by MQTT message name
  const {data, error} = await supabase.functions.invoke("get-pump-by-mqtt-msg-name", {
    body: {name},
  });

  if (error) {
    throw error;
  }

  return data as Tables<"pumps">;
};