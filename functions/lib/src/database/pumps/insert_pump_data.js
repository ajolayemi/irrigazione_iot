"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.insertPumpFlow = exports.insertPumpStatus = exports.insertPumpPressure = void 0;
const supabase_client_1 = require("../../services/supabase_client");
/**
 * References the insert-pump-pressure Supabase Edge function to insert pump pressure data
 * @param {TablesInsert<"pump_pressures">} data The data to insert
 * @return {Promise<void>} A promise that resolves when the data is inserted
 */
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
    return Promise.resolve();
};
exports.insertPumpPressure = insertPumpPressure;
/**
 * References the insert-pump-status Supabase Edge function to insert pump status data
 * @param {TablesInsert<"pump_statuses">} data The data to insert
 * @return {Promise<void>} A promise that resolves when the data is inserted
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
    return Promise.resolve();
};
exports.insertPumpStatus = insertPumpStatus;
/**
 * References the insert-pump-flow Supabase Edge function to insert pump flow data
 * @param {TablesInsert<"pump_flows">} data The data to insert
 * @return {Promise<void>} A promise that resolves when the data is inserted
 */
const insertPumpFlow = async (data) => {
    const supabase = await (0, supabase_client_1.createSupabaseClient)();
    const { error } = await supabase.functions.invoke("insert-pump-flow", {
        body: {
            data: data,
        },
    });
    if (error) {
        throw error;
    }
    return Promise.resolve();
};
exports.insertPumpFlow = insertPumpFlow;
//# sourceMappingURL=insert_pump_data.js.map