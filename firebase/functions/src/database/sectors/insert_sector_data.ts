import {TablesInsert} from "../../../schemas/database.types";
import {createSupabaseClient} from "../../services/supabase_client";

/**
 * References the insert-sector-pressure Supabase Edge function to insert sector pressure data
 * @param data The data to insert
 */
export const insertSectorPressure = async (
  data: TablesInsert<"sector_pressures">
): Promise<void> => {
  const supabase = await createSupabaseClient();
  const {error} = await supabase.functions.invoke("insert-sector-pressure", {
    body: {
      data: data,
    },
  });

  if (error) throw error;

  return;
};

/**
 * References the insert-sector-status Supabase Edge function to insert sector status data
 * @param data The data to insert
 */
export const insertSectorStatus = async (
  data: TablesInsert<"sector_statuses">
): Promise<void> => {
  const supabase = await createSupabaseClient();
  const {error} = await supabase.functions.invoke("insert-sector-status", {
    body: {
      data: data,
    },
  });
  if (error) throw error;
  return;
};
