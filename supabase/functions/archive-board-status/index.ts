import {commonArchive} from "../_utils/commonDatabaseOperations.ts";
import { TableNames } from "../_utils/tableConstants.ts";
console.log("Function archive-board-status called");

Deno.serve(
  async (req) =>
    await commonArchive(
      req,
      {
        tableName: `${TableNames.boards_statuses}`,
        storageBucketPath: `archives/${TableNames.boards_statuses}`,
        filePrefixName: "board_status",
        deleteDataAfterArchiving: true,
      }
    )
);