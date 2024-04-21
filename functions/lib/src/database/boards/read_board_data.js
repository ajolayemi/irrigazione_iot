"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getBoardByMqttMsgName = void 0;
const supabase_client_1 = require("../../services/supabase_client");
/**
 * References the get-board-by-mqtt-msg-name Supabase
 * Edge function to get a board by MQTT message name
 * @param {string} name The MQTT message name of the board to get
 * @return {Promise<Tables<"board">>} The board with the given MQTT message name if it exists
 */
const getBoardByMqttMsgName = async (name) => {
    const supabase = await (0, supabase_client_1.createSupabaseClient)();
    const { data, error } = await supabase.functions.invoke("get-board-by-mqtt-msg-name", {
        body: { name },
    });
    if (error)
        throw error;
    return data["result"];
};
exports.getBoardByMqttMsgName = getBoardByMqttMsgName;
//# sourceMappingURL=read_board_data.js.map