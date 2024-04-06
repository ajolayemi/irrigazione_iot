import {createEdgeSupabaseClient} from "./supabaseClient.ts";

/**
 * A common function to update a record in a table
 * @param req A request object
 * @param tableName The name of the table to update the record in
 * @returns A response object
 */
export const commonUpdate = async (req: Request, tableName: string): Promise<Response> => {
  try {
    const supabaseClient = createEdgeSupabaseClient(req);

    // Get the data to update
    const {toUpdate} = await req.json();

    // Update the record
    const {data, error} = await supabaseClient
      .from(tableName)
      .update(toUpdate)
      .eq("id", toUpdate.id)
      .select();
    
    if (error) throw error;

    return new Response(JSON.stringify({data}), {
      headers: {"Content-Type": "application/json"},
      status: 200,
    });
  } catch (error) {
    console.error(`An error occurred in commonUpdate: ${error.message}`);
    return new Response(JSON.stringify({error: error.message}), {
      status: 400,
      headers: {"Content-Type": "application/json"},
    });
  }
};
