"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.createSupabaseClient = void 0;
const secrets_1 = require("./secrets");
const supabase_js_1 = require("@supabase/supabase-js");
require('dotenv').config({ path: '../../../.env' });
/**
 * Creates a Supabase client with the provided URL and anon key
 * @return {Promise<SupabaseClient<Database>>} The Supabase client
 */
const createSupabaseClient = async () => {
    const env = process.env.NODE_ENV;
    const urlSecretKey = `supabase-url-${env}`;
    const supabaseKeySecretKey = `supabase-key-${env}`;
    const url = await (0, secrets_1.getSecretFromCloud)(urlSecretKey);
    const anon = await (0, secrets_1.getSecretFromCloud)(supabaseKeySecretKey);
    return (0, supabase_js_1.createClient)(url, anon);
};
exports.createSupabaseClient = createSupabaseClient;
//# sourceMappingURL=supabase_client.js.map