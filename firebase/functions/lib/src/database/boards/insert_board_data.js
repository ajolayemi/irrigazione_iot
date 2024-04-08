"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.insertBoardStatusData = void 0;
const supabase_client_1 = require("../../services/supabase_client");
const insertBoardStatusData = async (data) => {
    const supabase = await (0, supabase_client_1.createSupabaseClient)();
    const { error } = await supabase.functions.invoke("insert-board-status", {
        body: { data },
    });
    if (error)
        throw error;
    return data;
};
exports.insertBoardStatusData = insertBoardStatusData;
//# sourceMappingURL=insert_board_data.js.map