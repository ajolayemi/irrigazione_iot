"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.insertCollectorPressure = void 0;
const supabase_client_1 = require("../../services/supabase_client");
const insertCollectorPressure = async (data) => {
    const supabase = await (0, supabase_client_1.createSupabaseClient)();
    const { error } = await supabase.functions.invoke("insert-collector-pressure", {
        body: {
            data: data,
        },
    });
    if (error)
        throw error;
    return;
};
exports.insertCollectorPressure = insertCollectorPressure;
//# sourceMappingURL=insert_collector_data.js.map