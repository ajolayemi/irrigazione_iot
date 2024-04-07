import {TablesInsert} from "../../../schemas/database.types";
import {createSupabaseClient} from "../../services/supabase_client";

/**
 * References the insert-pump-pressure Supabase Edge function to insert pump pressure data
 * @param data The data to insert
 */
export const insertPumpPressure = async (
  data: TablesInsert<"pump_pressures">
): Promise<void> => {
  // Get the Supabase client
  const supabase = await createSupabaseClient();
  // Insert the pump pressure data
  const {error} = await supabase.functions.invoke("insert-pump-pressure", {
    body: {
      data: data,
    },
  });

  if (error) {
    throw error;
  }
};


/**
 * References the insert-pump-status Supabase Edge function to insert pump status data
 * @param data The data to insert
 */
export const insertPumpStatus = async (
  data: TablesInsert<"pump_statuses">
): Promise<void> => {
  // Get the Supabase client
  const supabase = await createSupabaseClient();
  // Insert the pump status data
  const {error} = await supabase.functions.invoke("insert-pump-status", {
    body: {
      data: data,
    },
  });

  if (error) {
    throw error;
  }
};
