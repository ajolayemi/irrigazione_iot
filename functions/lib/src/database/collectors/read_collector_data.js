"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getCollectorByMqttMsgName = void 0;
const supabase_client_1 = require("../../services/supabase_client");
const getCollectorByMqttMsgName = async (name) => {
    const supabase = await (0, supabase_client_1.createSupabaseClient)();
    const { data, error } = await supabase.functions.invoke("get-collector-by-mqtt-msg-name", { body: { name } });
    if (error)
        throw error;
    return data["result"];
};
exports.getCollectorByMqttMsgName = getCollectorByMqttMsgName;
//# sourceMappingURL=read_collector_data.js.map