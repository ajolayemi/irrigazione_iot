"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getCollectorBySectorId = exports.getSectorByMqttMsgName = void 0;
const supabase_client_1 = require("../../services/supabase_client");
/**
 * References the get-sector-by-mqtt-msg-name Supabase Edge function to get a sector by MQTT message name
 * @param name The MQTT message name of the sector to get
 * @returns The sector with the given MQTT message name if it exists
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
 * References the get-collector-by-sector-id Supabase Edge function to get a collector by sector id
 * The underline Edge function access the collector_sectors table to get the collector
 * @param sector_id The sector id to get the collector for
 * @returns
 */
const getCollectorBySectorId = async (sector_id) => {
    const supabase = await (0, supabase_client_1.createSupabaseClient)();
    const { data, error } = await supabase.functions.invoke("get-collector-by-sector-id", {
        body: { sector_id },
    });
    if (error)
        throw error;
    return data["result"];
};
exports.getCollectorBySectorId = getCollectorBySectorId;
//# sourceMappingURL=read_sector_data.js.map