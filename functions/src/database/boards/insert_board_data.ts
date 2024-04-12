import {TablesInsert} from "../../../schemas/database.types";
import {createSupabaseClient} from "../../services/supabase_client";

export const insertBoardStatusData = async (
  data: TablesInsert<"board_statuses">
) => {
  const supabase = await createSupabaseClient();

  const {error} = await supabase.functions.invoke("insert-board-status", {
    body: {data},
  });

  if (error) throw error;

  return data as TablesInsert<"board_statuses">;
};
