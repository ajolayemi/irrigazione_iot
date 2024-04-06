import {createEdgeSupabaseClient} from "./supabaseClient.ts";

/**
 * A common function to update a record in a table
 * @param req A request object
 * @param tableName The name of the table to update the record in
 * @returns A response object
 */
export const commonUpdate = async (
  req: Request,
  tableName: string
): Promise<Response> => {
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

/**
 * A common function to insert a record into a table
 * @param req A request object
 * @param tableName The name of the table to insert the record into
 * @param data The data to insert
 * @returns A response object
 */
export const commonInsert = async (
  req: Request,
  tableName: string
): Promise<Response> => {
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

/**
 * A common function to delete a record from a table
 * @param req A request object
 * @param tableName The name of the table to delete the record from
 * @returns A response object
 */
export const commonDelete = async (
  req: Request,
  tableName: string
): Promise<Response> => {
  try {
    const supabaseClient = createEdgeSupabaseClient(req);

    // Get the record id to delete
    const {id} = await req.json();

    // Delete the record
    const {error} = await supabaseClient.from(tableName).delete().match({id});
    if (error) throw error;
    return new Response(
      JSON.stringify({
        message: `Record deleted from ${tableName} successfully!`,
      }),
      {
        headers: {"Content-Type": "application/json"},
        status: 200,
      }
    );
  } catch (error) {
    console.error(`An error occurred in commonDelete: ${error.message}`);
    return new Response(JSON.stringify({error: error.message}), {
      status: 400,
      headers: {"Content-Type": "application/json"},
    });
  }
};

/**
 * A common function to get a record from a table by its id
 * @param req A request object
 * @param tableName The name of the table to get the record from
 * @param columnNames (optional) The column names to get from the record separated by commas
 * @returns A response object
 */
export const commonGetById = async (
  req: Request,
  tableName: string,
  columnNames?: string
): Promise<Response> => {
  try {
    const supabaseClient = createEdgeSupabaseClient(req);

    // Get the id provided in the request body
    const {id} = await req.json();

    // Get the record
    const {data: result, error} = await supabaseClient
      .from(tableName)
      .select(columnNames ?? "*")
      .eq("id", id as number)
      .maybeSingle();

    if (error) throw error;

    return new Response(JSON.stringify({result}), {
      headers: {"Content-Type": "application/json"},
      status: 200,
    });
  } catch (error) {
    console.error(`An error occurred in commonGetById: ${error.message}`);
    return new Response(JSON.stringify({error: error.message}), {
      status: 400,
      headers: {"Content-Type": "application/json"},
    });
  }
};

/**
 * There are some tables with "mqtt_msg_name" column which holds the short name
 * provided for items like pumps, sectors in MQTT messages received from the
 * boards (centraline). This function is used to get records from such tables
 * by their "mqtt_msg_name" column.
 * @param req A request object
 * @param tableName The name of the table to get the record from
 * @param columnNames (optional) The column names to get from the record separated by commas
 * @returns A response object
 */
export const commonGetByMqttMsgName = async (
  req: Request,
  tableName: string,
  columnNames?: string
): Promise<Response> => {
  try {
    const supabaseClient = createEdgeSupabaseClient(req);

    // Get the mqtt_msg_name provided in the request body
    const {mqtt_msg_name} = await req.json();

    // Get the record
    const {data: result, error} = await supabaseClient
      .from(tableName)
      .select(columnNames ?? "*")
      .eq("mqtt_msg_name", mqtt_msg_name as string)
      .maybeSingle();

    if (error) throw error;

    return new Response(JSON.stringify({result}), {
      headers: {"Content-Type": "application/json"},
      status: 200,
    });
  } catch (error) {
    console.error(
      `An error occurred in commonGetByMqttMsgName: ${error.message}`
    );
    return new Response(JSON.stringify({error: error.message}), {
      status: 400,
      headers: {"Content-Type": "application/json"},
    });
  }
};
