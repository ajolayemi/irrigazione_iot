import {commonArchive} from "../_utils/commonDatabaseOperations.ts";
import { TableNames } from "../_utils/tableConstants.ts";
console.log("Function archive-pump-flow called");

Deno.serve(
  async (req) =>
    await commonArchive(
      req,
      {
        tableName: `${TableNames.pump_flows}`,
        storageBucketPath: `archives/${TableNames.pump_flows}`,
        filePrefixName: "pump_flow",
        deleteDataAfterArchiving: true,
      }
    )
);