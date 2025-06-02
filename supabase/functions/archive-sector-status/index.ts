import {commonArchive} from "../_utils/commonDatabaseOperations.ts";
import { TableNames } from "../_utils/tableConstants.ts";
console.log("Function archive-sector-status called");

Deno.serve(
  async (req) =>
    await commonArchive(
      req,
      {
        tableName: `${TableNames.sector_statuses}`,
        storageBucketPath: `archives/${TableNames.sector_statuses}`,
        filePrefixName: "sector_status",
        deleteDataAfterArchiving: true,
      }
    )
);