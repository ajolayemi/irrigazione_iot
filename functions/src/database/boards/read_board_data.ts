import {Tables} from "../../../schemas/database.types";
import {ReferencedTablesQueryResult} from "../../interfaces/interfaces";
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

/**
 * References the query-board-referenced-tables Supabase Edge function
 * to get some necessary information when processing board data
 * for Google Sheets
 * @param {string} id The ID of the board
 * @return {Promise<ReferencedTablesQueryResult>} The necessary information for processing board data
 */
export const queryBoardReferencedTables = async (
  id: string
): Promise<ReferencedTablesQueryResult> => {
  try {
    const supabase = await createSupabaseClient();

    const {data, error} = await supabase.functions.invoke(
      "query-board-referenced-tables",
      {
        body: {id},
      }
    );

    if (error) {
      throw error;
    }

    const res = data["boards"];

    if (!res || !res.length) {
      throw new Error("No board found");
    }

    const item = res[0];

    console.log(`Query result: ${JSON.stringify(item)}`);

    return {
      item: {
        id: item.id,
        name: item.name,
      },
      referencedTable: item.companies,
    };
  } catch (error) {
    throw new Error(`Error querying board referenced tables: ${error}`);
  }
};
