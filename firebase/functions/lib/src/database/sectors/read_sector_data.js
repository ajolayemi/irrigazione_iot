"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getSectorByMqttMsgName = void 0;
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
    if (error) {
        throw error;
    }
    return data["result"];
};
exports.getSectorByMqttMsgName = getSectorByMqttMsgName;
//# sourceMappingURL=read_sector_data.js.map