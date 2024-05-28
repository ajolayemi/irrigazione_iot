import {Tables} from "../../../schemas/database.types";
import {WeatherStationReferencedTables} from "../../interfaces/interfaces";
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
  const {data, error} = await supabase.functions.invoke(
    "get-weather-station-by-eui",
    {
      body: {eui},
    }
  );

  if (error) {
    throw error;
  }

  return data["result"] as Tables<"weather_stations">;
};

/**
 * References the query-weather-station-referenced-tables Supabase Edge function
 * to get some necessary information when processing SenseCap weather station data
 * for Google Sheets
 * @param {string} id The id of the weather station
 * @return {Promise<WeatherStationReferencedTables>} The necessary information for processing SenseCap data
 * like company name, sector name, and weather station name
 */
export const queryWeatherStationReferencedTables = async (
  id: string
): Promise<WeatherStationReferencedTables> => {
  // Get the Supabase client
  const supabase = await createSupabaseClient();

  const {data, error} = await supabase.functions.invoke(
    "query-weather-station-referenced-tables",
    {
      body: {id},
    }
  );

  if (error) {
    throw error;
  }

  const res = data["weather_stations"];

  if (!res || !res.length) {
    throw new Error("No weather station found");
  }

  const item = res[0];

  return {
    station: {
      id: item.id as number,
      name: item.name as string,
      eui: item.eui as string,
    },
    sector: item.sectors,
    company: item.companies,
  };
};
