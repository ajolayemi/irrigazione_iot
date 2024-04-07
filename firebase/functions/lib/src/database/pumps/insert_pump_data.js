"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.insertPumpStatus = exports.insertPumpPressure = void 0;
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
/**
 * References the insert-pump-status Supabase Edge function to insert pump status data
 * @param data The data to insert
 */
const insertPumpStatus = async (data) => {
    // Get the Supabase client
    const supabase = await (0, supabase_client_1.createSupabaseClient)();
    // Insert the pump status data
    const { error } = await supabase.functions.invoke("insert-pump-status", {
        body: {
            data: data,
        },
    });
    if (error) {
        throw error;
    }
};
exports.insertPumpStatus = insertPumpStatus;
//# sourceMappingURL=insert_pump_data.js.map