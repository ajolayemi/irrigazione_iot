"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.insertTerminalPressure = void 0;
const supabase_client_1 = require("../../services/supabase_client");
const insertTerminalPressure = async (data) => {
    const supabase = await (0, supabase_client_1.createSupabaseClient)();
    const { error } = await supabase.functions.invoke("insert-terminal-pressure", {
        body: {
            data: data,
        },
    });
    if (error)
        throw error;
    return;
};
exports.insertTerminalPressure = insertTerminalPressure;
//# sourceMappingURL=insert_terminal_data.js.map