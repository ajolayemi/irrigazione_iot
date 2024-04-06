import {Tables} from "../../../schemas/supabase";
import {createSupabaseClient} from "../../services/supabase_client";

export const getPumpById = async (id: string): Promise<Tables<"pumps">> => {
  // Get the Supabase client
  const supabase = await createSupabaseClient();
  // Get the pump by id
  const {data, error} = await supabase.functions.invoke("get-pump-by-id", {
    body: {id},
  });

  if (error) {
    throw error;
  }

  return data as Tables<"pumps">;
};
