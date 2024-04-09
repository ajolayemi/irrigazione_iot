"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getCompanyById = void 0;
const supabase_client_1 = require("../../services/supabase_client");
/**
 * References the get-company-by-id Supabase
 * Edge function to get a company by id
 * @param {string} id The id of the company to get
 * @return {Promise<Tables<"companies">>} The company with the given id
 */
const getCompanyById = async (id) => {
    // Get the Supabase client
    const supabase = await (0, supabase_client_1.createSupabaseClient)();
    // Get the company by id
    const { data, error } = await supabase.functions.invoke("get-company-by-id", {
        body: { id },
    });
    if (error) {
        throw error;
    }
    return data["result"];
};
exports.getCompanyById = getCompanyById;
//# sourceMappingURL=read_company_data.js.map