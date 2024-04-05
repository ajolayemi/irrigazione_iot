import { createSupabaseClient } from "../../services/supabase_client";


/**
 * Deletes a company from the database
 * @param id The id of the company to delete
 */
export const deleteCompany = async (id: string): Promise<void> => {
    // Get the Supabase client
    const supabase = await createSupabaseClient();
    // Delete the company
    const {error} = await supabase.functions.invoke("delete-company", {
        body: {id},
    });

    if (error) {
        throw error;
    }
}