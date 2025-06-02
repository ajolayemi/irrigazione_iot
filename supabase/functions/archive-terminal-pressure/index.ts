import {commonArchive} from "../_utils/commonDatabaseOperations.ts";
import { TableNames } from "../_utils/tableConstants.ts";
console.log("Function archive-terminal-pressure called");

Deno.serve(
  async (req) =>
    await commonArchive(
      req,
      {
        tableName: `${TableNames.terminal_pressures}`,
        storageBucketPath: `archives/${TableNames.terminal_pressures}`,
        filePrefixName: "terminal_pressure",
        deleteDataAfterArchiving: true,
      }
    )
);