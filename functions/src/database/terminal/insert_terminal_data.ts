import {TablesInsert} from "../../../schemas/database.types";
import {createSupabaseClient} from "../../services/supabase_client";

export const insertTerminalPressure = async (
  data: TablesInsert<"terminal_pressures">
): Promise<void> => {
  const supabase = await createSupabaseClient();
  const {error} = await supabase.functions.invoke("insert-terminal-pressure", {
    body: {
      data: data,
    },
  });

  if (error) throw error;

  return;
};
