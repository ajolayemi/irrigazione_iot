"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getCollectorBySectorId = exports.getSectorByMqttMsgName = void 0;
const supabase_client_1 = require("../../services/supabase_client");
/**
 * References the get-sector-by-mqtt-msg-name Supabase Edge function to get a sector by
 * MQTT message name
 * @param {string} name The MQTT message name of the sector to get
 * @return {Promise<Tables<"sectors">>} The sector with the given MQTT message name if it exists
 */
const getSectorByMqttMsgName = async (name) => {
    // Get the Supabase client
    const supabase = await (0, supabase_client_1.createSupabaseClient)();
    // Get the sector by MQTT message name
    const { data, error } = await supabase.functions.invoke("get-sector-by-mqtt-msg-name", {
        body: { name },
    });
    if (error)
        throw error;
    return data["result"];
};
exports.getSectorByMqttMsgName = getSectorByMqttMsgName;
/**
 * References the get-collector-by-sector-id Supabase Edge function
 * to get a collector sector by sector id
 * The underline Edge function access the collector_sectors table to get the collector
 * @param {string} sectorId The sector id to get the collector for
 * @return {Promise<Tables<"collector_sectors">>} The collector sector with the given sector id
 */
const getCollectorBySectorId = async (sectorId) => {
    const supabase = await (0, supabase_client_1.createSupabaseClient)();
    const { data, error } = await supabase.functions.invoke("get-collector-by-sector-id", {
        body: { sector_id: sectorId },
    });
    if (error)
        throw error;
    return data["result"];
};
exports.getCollectorBySectorId = getCollectorBySectorId;
//# sourceMappingURL=read_sector_data.js.map