import {corsHeaders} from "./cors.ts";
import {createEdgeSupabaseClient} from "./supabaseClient.ts";
import {buildArchiveFileFullName, getDaysAgo} from "../_utils/utils.ts";
import {DataArchiveArgs} from "./tableConstants.ts";

export const commonArchive = async (
  req: Request,
  arg: DataArchiveArgs
): Promise<Response> => {
  // This is needed if you're planning to invoke your function from a browser.
  if (req.method === "OPTIONS") {
    return new Response("ok", {headers: corsHeaders});
  }

  try {
    const now = new Date();
    const daysAgoRes = getDaysAgo(arg.daysAgo);

    const fileName = buildArchiveFileFullName(now, arg.filePrefixName);
    const supabaseClient = createEdgeSupabaseClient(req);

    const tableName = arg.tableName;

    const query = supabaseClient
      .from(tableName)
      .select()
      .gte("created_at", daysAgoRes.toISOString());

    const {data} = await query.csv();

    if (!data || data.length === 1) {
      const emptyStateText = `No data to archive from table ${tableName}`;
      console.log(emptyStateText);
      return new Response(
        JSON.stringify({
          data: emptyStateText,
        }),
        {
          status: 200,
        }
      );
    }

    // Store data to storage
    await storeDataToStorage(
      req,
      arg.storageBucketPath,
      fileName,
      data,
      arg.contentType ?? "text/csv"
    );

    if (arg.deleteDataAfterArchiving) {
      console.log(
        `Deleting data greater than or equals ${daysAgoRes} from ${tableName}`
      );
      await supabaseClient
        .from(tableName)
        .delete()
        .gte("created_at", daysAgoRes.toISOString());
    }

    return new Response(
      JSON.stringify({
        data: `Data from table ${tableName} archived successfully`,
      }),
      {
        status: 200,
      }
    );
  } catch (error) {
    return new Response(
      JSON.stringify({
        error: error,
      }),
      {
        status: 500,
        headers: {"Content-Type": "application/json"},
      }
    );
  }
};

/**
 * Holds onto a common logic to archive data to supabase storage
 * @param req A request object
 * @param bucketPath The full path to the bucket where data should be stored
 * @param fileName The name to be assigned to the file
 * @param data The data to be stored
 * @param contentType The content type to be assigned to the data
 */
export const storeDataToStorage = async (
  req: Request,
  bucketPath: string,
  fileName: string,
  data: string,
  contentType?: string
): Promise<Response> => {
  // This is needed if you're planning to invoke your function from a browser.
  if (req.method === "OPTIONS") {
    return new Response("ok", {headers: corsHeaders});
  }
  try {
    const supabaseClient = createEdgeSupabaseClient(req);
    const {error: uploadError} = await supabaseClient.storage
      .from(bucketPath)
      .upload(fileName, new Blob([data]), {
        contentType: contentType,
        upsert: true,
      });

    if (uploadError) {
      console.log("Error uploading:", uploadError.message);
      return new Response("Upload failed", {status: 500});
    }

    return new Response("File uploaded successfully", {
      status: 200,
      headers: {"Content-Type": "application/json"},
    });
  } catch (error) {
    return new Response(
      JSON.stringify({
        error: error,
      }),
      {
        status: 500,
        headers: {"Content-Type": "application/json"},
      }
    );
  }
};

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
  // This is needed if you're planning to invoke your function from a browser.
  if (req.method === "OPTIONS") {
    return new Response("ok", {headers: corsHeaders});
  }
  try {
    const supabaseClient = createEdgeSupabaseClient(req);

    // Get the data to update
    const {data: toUpdate, id} = await req.json();

    // Update the record
    const {data, error} = await supabaseClient
      .from(tableName)
      .update(toUpdate)
      .eq("id", id)
      .select()
      .maybeSingle();

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
  tableName: string,
  shouldReturnData = true
): Promise<Response> => {
  // This is needed if you're planning to invoke your function from a browser.
  if (req.method === "OPTIONS") {
    return new Response("ok", {headers: corsHeaders});
  }
  try {
    const supabaseClient = createEdgeSupabaseClient(req);

    const {data: toInsert} = await req.json();

    const baseQuery = supabaseClient.from(tableName).insert(toInsert);
    // Insert the new record
    const {data, error} = shouldReturnData
      ? await baseQuery.select().maybeSingle()
      : await baseQuery;
    if (error) throw error;
    return new Response(
      JSON.stringify({data, message: `Record inserted into ${tableName}!`}),
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
  // This is needed if you're planning to invoke your function from a browser.
  if (req.method === "OPTIONS") {
    return new Response("ok", {headers: corsHeaders});
  }
  try {
    const supabaseClient = createEdgeSupabaseClient(req);

    // Get the record id to delete, a list of ids can also be provided
    const {ids} = await req.json();

    // Delete the record
    const {
      status: stat,
      statusText,
      error,
    } = await supabaseClient.from(tableName).delete().in("id", ids);
    if (error) throw error;
    return new Response(
      JSON.stringify({
        status: stat,
        statusText,
      }),
      {
        headers: {"Content-Type": "application/json"},
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
  // This is needed if you're planning to invoke your function from a browser.
  if (req.method === "OPTIONS") {
    return new Response("ok", {headers: corsHeaders});
  }
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
  // This is needed if you're planning to invoke your function from a browser.
  if (req.method === "OPTIONS") {
    return new Response("ok", {headers: corsHeaders});
  }
  try {
    const supabaseClient = createEdgeSupabaseClient(req);

    // Get the mqtt_msg_name provided in the request body
    const {name} = await req.json();

    // Get the record
    const {data: result, error} = await supabaseClient
      .from(tableName)
      .select(columnNames ?? "*")
      .eq("mqtt_msg_name", name)
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

/**
 * A common function that access tables like pump_pressures, collector_pressures, etc.
 * It gets the last record from the table for a specific provided id that could be
 * pump_id, collector_id, etc.
 * @param req A request object
 * @param tableName The name of the table to get the record from
 * @param colName The name of the column to use in filtering the table
 * @param columnNames (optional) The column names to get from the record separated by commas
 * @returns A response object
 */
export const commonGetLastRecordById = async (
  req: Request,
  tableName: string,
  colName: string,
  columnNames?: string | undefined
): Promise<Response> => {
  try {
    const supabaseClient = createEdgeSupabaseClient(req);
    const {id} = await req.json();

    // Get the last record for the provided id
    const {data: result, error} = await supabaseClient
      .from(tableName)
      .select(columnNames ?? "*")
      .eq(colName, id as number)
      .order("created_at", {ascending: false})
      .limit(1)
      .maybeSingle();

    if (error) throw error;

    return new Response(JSON.stringify({result}), {
      headers: {"Content-Type": "application/json"},
      status: 200,
    });
  } catch (error) {
    console.error(
      `An error occurred in commonGetLastRecordById: ${error.message}`
    );
    return new Response(JSON.stringify({error: error.message}), {
      status: 400,
      headers: {"Content-Type": "application/json"},
    });
  }
};

/***
 * There are some tables with "eui" column which holds the unique identifier
 * provided for items like sensors in MQTT messages received from the
 * sensecap devices. This function is used to get records from such tables
 * by their "eui" column.
 * @param req A request object
 * @param tableName The name of the table to get the record from
 * @param columnNames (optional) The column names to get from the record separated by commas
 * @returns A response object
 */
export const commonGetByEui = async (
  req: Request,
  tableName: string,
  columnNames?: string
): Promise<Response> => {
  // This is needed if you're planning to invoke your function from a browser.
  if (req.method === "OPTIONS") {
    return new Response("ok", {headers: corsHeaders});
  }
  try {
    const supabaseClient = createEdgeSupabaseClient(req);

    // Get the eui provided in the request body
    const {eui} = await req.json();

    // Get the record
    const {data: result, error} = await supabaseClient
      .from(tableName)
      .select(columnNames ?? "*")
      .eq("eui", eui)
      .maybeSingle();

    if (error) throw error;

    return new Response(JSON.stringify({result}), {
      headers: {"Content-Type": "application/json"},
      status: 200,
    });
  } catch (error) {
    console.error(`An error occurred in commonGetByEui: ${error.message}`);
    return new Response(JSON.stringify({error: error.message}), {
      status: 400,
      headers: {"Content-Type": "application/json"},
    });
  }
};
