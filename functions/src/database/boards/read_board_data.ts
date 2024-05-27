import {Tables} from "../../../schemas/database.types";
import {createSupabaseClient} from "../../services/supabase_client";

/**
 * References the get-board-by-eui Supabase
 * Edge function to get a board by MQTT message name
 * @param {string} eui The EUI of the board to get
 * @return {Promise<Tables<"board">>} The board with the given MQTT message name if it exists
 */
export const getBoardByEui = async (eui: string): Promise<Tables<"boards">> => {
  const supabase = await createSupabaseClient();
  const {data, error} = await supabase.functions.invoke("get-board-by-eui", {
    body: {eui},
  });
  if (error) throw error;
  return data["result"] as Tables<"boards">;
};

/**
 * References the get-board-by-id Supabase
 * Edge function to get a board by ID
 * @param {string} id The ID of the board to get
 * @return {Promise<Tables<"board">>} The board with the given ID if it exists
 */
export const getBoardById = async (id: string): Promise<Tables<"boards">> => {
  const supabase = await createSupabaseClient();
  const {data, error} = await supabase.functions.invoke("get-board-by-id", {
    body: {id},
  });
  if (error) throw error;
  return data["result"] as Tables<"boards">;
};
