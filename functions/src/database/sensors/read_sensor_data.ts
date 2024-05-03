import {Tables} from "../../../schemas/database.types";
import {createSupabaseClient} from "../../services/supabase_client";

/**
 * References the get-sensor-by-eui Supabase Edge function to get a sensor by device eui
 * @param {string} eui The device eui of the sensor to get
 * @return {Promise<Tables<"sensors">>} The sensor with the given device eui
 */
export const getSensorByEui = async (
  eui: string
): Promise<Tables<"sensors">> => {
  // Get the Supabase client
  const supabase = await createSupabaseClient();

  // Get the sensor by device eui
  const {data, error} = await supabase.functions.invoke("get-sensor-by-eui", {
    body: {eui},
  });

  if (error) {
    throw error;
  }

  return data["result"] as Tables<"sensors">;
};
