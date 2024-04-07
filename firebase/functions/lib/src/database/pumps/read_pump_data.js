"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getPumpByMqttMsgName = exports.getPumpById = void 0;
const supabase_client_1 = require("../../services/supabase_client");
const getPumpById = async (id) => {
    // Get the Supabase client
    const supabase = await (0, supabase_client_1.createSupabaseClient)();
    // Get the pump by id
    const { data, error } = await supabase.functions.invoke("get-pump-by-id", {
        body: { id },
    });
    if (error) {
        throw error;
    }
    return data["result"];
};
exports.getPumpById = getPumpById;
const getPumpByMqttMsgName = async (name) => {
    // Get the Supabase client
    const supabase = await (0, supabase_client_1.createSupabaseClient)();
    // Get the pump by MQTT message name
    const { data, error } = await supabase.functions.invoke("get-pump-by-mqtt-msg-name", {
        body: { name },
    });
    if (error) {
        throw error;
    }
    return data["result"];
};
exports.getPumpByMqttMsgName = getPumpByMqttMsgName;
//# sourceMappingURL=read_pump_data.js.map