import { TablesInsert } from "../../../schemas/database.types";
import { createSupabaseClient } from "../../services/supabase_client";

export const insertCompany = async (data: TablesInsert<'companies'>): Promise<void> => {
    // Get the Supabase client
    const supabase = await createSupabaseClient();
    // Insert the company
    const {error} = await supabase.functions.invoke("insert-new-company", {
        body: {"data": data},
    });

    if (error) {
        console.error(`An error occurred in insertCompany: ${error.message}`);
        throw error;
    }
}