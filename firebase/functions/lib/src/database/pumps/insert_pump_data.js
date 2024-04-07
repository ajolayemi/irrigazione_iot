"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.insertPumpPressure = void 0;
const supabase_client_1 = require("../../services/supabase_client");
const insertPumpPressure = async (data) => {
    // Get the Supabase client
    const supabase = await (0, supabase_client_1.createSupabaseClient)();
    // Insert the pump pressure data
    const { error } = await supabase.functions.invoke("insert-pump-pressure", {
        body: {
            data: data,
        },
    });
    if (error) {
        throw error;
    }
};
exports.insertPumpPressure = insertPumpPressure;
//# sourceMappingURL=insert_pump_data.js.map