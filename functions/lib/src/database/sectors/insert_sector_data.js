"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.insertSectorStatus = exports.insertSectorPressure = void 0;
const supabase_client_1 = require("../../services/supabase_client");
/**
 * References the insert-sector-pressure Supabase Edge function to insert sector pressure data
 * @param {TablesInsert<"sector_pressures">} data The data to insert
 * @return {Promise<void>} A promise that resolves when the data is inserted
 */
const insertSectorPressure = async (data) => {
    const supabase = await (0, supabase_client_1.createSupabaseClient)();
    const { error } = await supabase.functions.invoke("insert-sector-pressure", {
        body: {
            data: data,
        },
    });
    if (error)
        throw error;
    return Promise.resolve();
};
exports.insertSectorPressure = insertSectorPressure;
/**
 * References the insert-sector-status Supabase Edge function to insert sector status data
 * @param {TablesInsert<"sector_statuses">} data The data to insert
 * @return {Promise<void>} A promise that resolves when the data is inserted
 */
const insertSectorStatus = async (data) => {
    const supabase = await (0, supabase_client_1.createSupabaseClient)();
    const { error } = await supabase.functions.invoke("insert-sector-status", {
        body: {
            data: data,
        },
    });
    if (error)
        throw error;
    return Promise.resolve();
};
exports.insertSectorStatus = insertSectorStatus;
//# sourceMappingURL=insert_sector_data.js.map