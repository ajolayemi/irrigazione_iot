import {commonArchive} from "../_utils/commonDatabaseOperations.ts";
import { TableNames } from "../_utils/tableConstants.ts";
console.log("Function archive-pump-pressure called");

Deno.serve(
  async (req) =>
    await commonArchive(
      req,
      {
        tableName: `${TableNames.pump_pressures}`,
        storageBucketPath: `archives/${TableNames.pump_pressures}`,
        filePrefixName: "pump_pressure",
        deleteDataAfterArchiving: true,
      }
    )
);
