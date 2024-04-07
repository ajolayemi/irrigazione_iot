import {TablesInsert} from "../../../schemas/database.types";
import {createSupabaseClient} from "../../services/supabase_client";

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
