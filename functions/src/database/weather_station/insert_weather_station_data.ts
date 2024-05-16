import {TablesInsert} from "../../../schemas/database.types";
import {createSupabaseClient} from "../../services/supabase_client";

/**
 * It uses Edge Function to insert weather station measurement data to the database
 * @param {TablesInsert<"weather_station_measurements">} data The data to insert
 * @return {Promise<void>} A promise that resolves when the data is inserted
 */
export const insertWeatherStationMeasurementData = async (
  data: TablesInsert<"weather_station_measurements">
): Promise<void> => {
  const supabase = await createSupabaseClient();

  const {error} = await supabase.functions.invoke("insert-weather-station-measurement", {
    body: {
      data: data,
    },
  });

  if (error) {
    throw error;
  }
  return Promise.resolve();
};

/**
 * It uses Edge Function to insert weather station battery data to the database
 * @param {TablesInsert<"weather_station_battery_data">} data The data to insert
 * @return {Promise<void>} A promise that resolves when the data is inserted
 */
export const insertWeatherStationBatteryData = async (
  data: TablesInsert<"weather_station_battery_data">
): Promise<void> => {
  const supabase = await createSupabaseClient();
  const {error} = await supabase.functions.invoke("insert-weather-station-battery", {
    body: {
      data: data,
    },
  });

  if (error) {
    throw error;
  }

  return Promise.resolve();
};
