import {commonArchive} from "../_utils/commonDatabaseOperations.ts";
import { TableNames } from "../_utils/tableConstants.ts";
console.log("Function archive-pump-status called");

Deno.serve(
  async (req) =>
    await commonArchive(
      req,
      {
        tableName: `${TableNames.pump_statuses}`,
        storageBucketPath: `archives/${TableNames.pump_statuses}`,
        filePrefixName: "pump_status",
        deleteDataAfterArchiving: true,
      }
    )
);