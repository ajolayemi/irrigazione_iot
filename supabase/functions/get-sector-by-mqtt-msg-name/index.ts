import {TableNames} from "../_utils/tableConstants.ts";
import {commonGetByMqttMsgName} from "../_utils/commonDatabaseOperations.ts";

console.log(`Function "get-sector-by-mqtt-msg-name" up and running!`);

Deno.serve(
  async (req) => await commonGetByMqttMsgName(req, TableNames.sectors)
);
