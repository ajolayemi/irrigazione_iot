"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.insertCompany = void 0;
const supabase_client_1 = require("../../services/supabase_client");
const insertCompany = async (data) => {
    // Get the Supabase client
    const supabase = await (0, supabase_client_1.createSupabaseClient)();
    // Insert the company
    const { error } = await supabase.functions.invoke("insert-new-company", {
        body: { "data": data },
    });
    if (error) {
        console.error(`An error occurred in insertCompany: ${error.message}`);
        throw error;
    }
};
exports.insertCompany = insertCompany;
//# sourceMappingURL=insert_company_data.js.map