/// Contains functions to read data from the database (Supabase)
import {Tables} from "../../schemas/supabase";
import {createSupabaseClient} from "../services/supabase_client";

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

    return data as Tables<'companies'>;
}