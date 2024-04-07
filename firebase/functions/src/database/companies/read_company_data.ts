/// Contains functions to read data from the database (Supabase)
import { Tables } from "../../../schemas/database.types";
import { createSupabaseClient } from "../../services/supabase_client";

/**
 * References the get-company-by-id Supabase Edge function to get a company by id
 * @param id The id of the company to get
 * @returns The company with the given id
 */
export const getCompanyById = async (id: string): Promise<Tables<'companies'>> => {
    // Get the Supabase client
    const supabase = await createSupabaseClient();
    // Get the company by id
    const {data, error} = await supabase.functions.invoke("get-company-by-id", {
        body: {id},
    });

    if (error) {
        throw error;
    }

    return data["result"] as Tables<'companies'>;
}