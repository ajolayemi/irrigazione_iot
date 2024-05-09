import {TablesInsert} from "../../../schemas/database.types";
import {createSupabaseClient} from "../../services/supabase_client";

/**
 * It uses Edge Function to insert sensor measurement data to the database
 * @param {TablesInsert<"sensor_measurements">} data The data to insert
 * @return {Promise<void>} A promise that resolves when the data is inserted
 */
export const insertSensorMeasurementData = async (
  data: TablesInsert<"sensor_measurements">
): Promise<void> => {
  // Get the Supabase client
  const supabase = await createSupabaseClient();
  // Insert the sensor data
  const {error} = await supabase.functions.invoke("insert-sensor-measurement", {
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
 * It uses Edge Function to insert sensor battery data to the database
 * @param {TablesInsert<"sensor_batteries">} data The data to insert
 * @return {Promise<void>} A promise that resolves when the data is inserted
 */
export const insertSensorBatteryData = async (
  data: TablesInsert<"sensor_battery_data">
): Promise<void> => {
  // Get the Supabase client
  const supabase = await createSupabaseClient();

  // Insert the sensor battery data
  const {error} = await supabase.functions.invoke("insert-sensor-battery", {
    body: {
      data: data,
    },
  });

  if (error) {
    throw error;
  }

  return Promise.resolve();
};
