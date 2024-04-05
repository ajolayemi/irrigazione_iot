"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.createSupabaseClient = void 0;
const secrets_1 = require("./secrets");
const supabase_js_1 = require("@supabase/supabase-js");
/**
 * Creates a Supabase client with the provided URL and anon key
 * @returns {Promise<SupabaseClient<Database>>} The Supabase client
 */
const createSupabaseClient = async () => {
    const url = await (0, secrets_1.getSecretFromCloud)("SUPABASE_URL");
    const anon = await (0, secrets_1.getSecretFromCloud)("SUPABASE_ANON_KEY");
    return (0, supabase_js_1.createClient)(url, anon);
};
exports.createSupabaseClient = createSupabaseClient;
//# sourceMappingURL=supabase_client.js.map