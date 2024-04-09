import {TablesInsert} from "../../../schemas/database.types";
import {createSupabaseClient} from "../../services/supabase_client";

export const insertCollectorPressure = async (
  data: TablesInsert<"collector_pressures">
): Promise<void> => {
  const supabase = await createSupabaseClient();
  const {error} = await supabase.functions.invoke("insert-collector-pressure", {
    body: {
      data: data,
    },
  });

  if (error) throw error;

  return;
};
