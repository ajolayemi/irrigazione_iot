"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.updateCompany = void 0;
const supabase_client_1 = require("../../services/supabase_client");
const updateCompany = async (toUpdate) => {
    // Get the Supabase client
    const supabase = await (0, supabase_client_1.createSupabaseClient)();
    // Update the company
    const { data, error } = await supabase.functions.invoke("update-company", {
        body: { toUpdate: toUpdate },
    });
    if (error) {
        throw error;
    }
    return data;
};
exports.updateCompany = updateCompany;
//# sourceMappingURL=update_company_data.js.map