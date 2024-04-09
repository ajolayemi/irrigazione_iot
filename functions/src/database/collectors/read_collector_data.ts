import {Tables} from "../../../schemas/database.types";
import {createSupabaseClient} from "../../services/supabase_client";

export const getCollectorByMqttMsgName = async (
  name: string
): Promise<Tables<"collectors">> => {
  const supabase = await createSupabaseClient();
  const {data, error} = await supabase.functions.invoke(
    "get-collector-by-mqtt-msg-name",
    {body: {name}}
  );

  if (error) throw error;

  return data["result"] as Tables<"collectors">;
};
