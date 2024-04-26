import {commonGetByMqttMsgName} from "../_utils/commonDatabaseOperations.ts";
import { ColumnNames } from "../_utils/tableConstants.ts";
import {TableNames} from "../_utils/tableConstants.ts";

console.log(`Function "get-pump-by-mqtt-msg-name" up and running!`);

Deno.serve(async (req) => {
  return await commonGetByMqttMsgName(req, TableNames.pumps, ColumnNames.columns_to_get_for_mqtt);
});
