import {Tables} from "../../../schemas/database.types";
import {createSupabaseClient} from "../../services/supabase_client";

/**
 * References the get-board-by-mqtt-msg-name Supabase
 * Edge function to get a board by MQTT message name
 * @param {string} name The MQTT message name of the board to get
 * @return {Promise<Tables<"board">>} The board with the given MQTT message name if it exists
 */
export const getBoardByMqttMsgName = async (
  name: string
): Promise<Tables<"boards">> => {
  const supabase = await createSupabaseClient();
  const {data, error} = await supabase.functions.invoke(
    "get-board-by-mqtt-msg-name",
    {
      body: {name},
    }
  );
  if (error) throw error;
  return data["result"] as Tables<"boards">;
};
