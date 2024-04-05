"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
require("dotenv").config({ path: `../../../.env.${process.env.NODE_ENV}` });
const supabase_js_1 = require("@supabase/supabase-js");
const supabase = (0, supabase_js_1.createClient)(process.env.SUPABASE_URL, process.env.SUPABASE_ANON_KEY);
(async () => {
    const { data, error } = await supabase.functions.invoke("get-company-by-id", {
        body: { name: "Jolayemi" },
    });
    console.log(data, error);
})();
// console.log(process.env.SUPABASE_URL);
// console.log(process.env.SUPABASE_ANON_KEY);
//# sourceMappingURL=test_supabase.js.map