import {commonArchive} from "../_utils/commonDatabaseOperations.ts";
import { TableNames } from "../_utils/tableConstants.ts";
console.log("Function archive-sector-pressure called");

Deno.serve(
  async (req) =>
    await commonArchive(
      req,
      {
        tableName: `${TableNames.sector_pressures}`,
        storageBucketPath: `archives/${TableNames.sector_pressures}`,
        filePrefixName: "sector_pressure",
        deleteDataAfterArchiving: true,
      }
    )
);