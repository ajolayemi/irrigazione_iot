import {commonArchive} from "../_utils/commonDatabaseOperations.ts";
import { TableNames } from "../_utils/tableConstants.ts";
console.log("Function archive-collector-pressure called");

Deno.serve(
  async (req) =>
    await commonArchive(
      req,
      {
        tableName: `${TableNames.collector_pressures}`,
        storageBucketPath: `archives/${TableNames.collector_pressures}`,
        filePrefixName: "collector_pressure",
        deleteDataAfterArchiving: true,
      }
    )
);