import {createEdgeSupabaseClient} from "./supabaseClient.ts";

/**
 * A common function to insert a record into a table
 * @param req A request object
 * @param tableName The name of the table to insert the record into
 * @param data The data to insert
 * @returns A response object
 */
export const commonInsert = async (
  req: Request,
  tableName: string,
) => {
  try {
    const supabaseClient = createEdgeSupabaseClient(req);

    const {data} = await req.json();
    // Insert the new record
    const {error} = await supabaseClient.from(tableName).insert(data);
    if (error) throw error;
    return new Response(
      JSON.stringify({message: `Data inserted in ${tableName} successfully!`}),
      {
        headers: {"Content-Type": "application/json"},
        status: 200,
      }
    );
  } catch (error) {
    console.error(`An error occurred in commonInsert: ${error.message}`);
    return new Response(JSON.stringify({error: error.message}), {
      status: 400,
      headers: {"Content-Type": "application/json"},
    });
  }
};
