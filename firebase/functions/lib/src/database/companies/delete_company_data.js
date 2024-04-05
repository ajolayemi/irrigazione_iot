"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.deleteCompany = void 0;
const supabase_client_1 = require("../../services/supabase_client");
/**
 * Deletes a company from the database
 * @param id The id of the company to delete
 */
const deleteCompany = async (id) => {
    // Get the Supabase client
    const supabase = await (0, supabase_client_1.createSupabaseClient)();
    // Delete the company
    const { error } = await supabase.functions.invoke("delete-company", {
        body: { id },
    });
    if (error) {
        throw error;
    }
};
exports.deleteCompany = deleteCompany;
//# sourceMappingURL=delete_company_data.js.map