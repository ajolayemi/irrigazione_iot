import {TablesUpdate} from "../../../schemas/supabase";
import {createSupabaseClient} from "../../services/supabase_client";

export const updateCompany = async (
  toUpdate: TablesUpdate<"companies">
): Promise<TablesUpdate<"companies">> => {
  // Get the Supabase client
  const supabase = await createSupabaseClient();
  // Update the company
  const {data, error} = await supabase.functions.invoke("update-company", {
    body: {toUpdate: toUpdate},
  });

  if (error) {
    throw error;
  }

  return data as TablesUpdate<"companies">;
};
