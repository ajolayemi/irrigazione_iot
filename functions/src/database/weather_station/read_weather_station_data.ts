import {Tables} from "../../../schemas/database.types";
import {createSupabaseClient} from "../../services/supabase_client";

/**
 * References the get-weather-station-by-eui Supabase Edge function
 * to get a weather station by device eui
 * @param {string} eui The device eui of the sensor to get
 * @return {Promise<Tables<"weather_stations">>} The sensor with the given device eui
 */
export const getWeatherStationByEui = async (
  eui: string
): Promise<Tables<"weather_stations">> => {
  // Get the Supabase client
  const supabase = await createSupabaseClient();
  const {data, error} = await supabase.functions.invoke("get-weather-station-by-eui", {
    body: {eui},
  });

  if (error) {
    throw error;
  }

  return data["result"] as Tables<"weather_stations">;
};
