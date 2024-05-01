import {TableNames} from "../_utils/tableConstants.ts";
import {commonGetByMqttMsgName} from "../_utils/commonDatabaseOperations.ts";
import {ColumnNames} from "../_utils/tableConstants.ts";

console.log(`Function "get-sector-by-mqtt-msg-name" up and running!`);

/**
 * Get a sector by its MQTT message name. The id of the sector is returned.
 */
Deno.serve(
  async (req) =>
    await commonGetByMqttMsgName(
      req,
      TableNames.sectors,
      ColumnNames.columns_to_get_for_mqtt
    )
);
