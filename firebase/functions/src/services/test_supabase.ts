require("dotenv").config({path: `../../../.env.${process.env.NODE_ENV}`});

import {createClient} from "@supabase/supabase-js";

const supabase = createClient(
    process.env.SUPABASE_URL as string,
    process.env.SUPABASE_ANON_KEY as string
);

(async () => {
    const {data, error} = await supabase.functions.invoke("hello-world", {
        body: {name: "Functions"},
    });

    console.log(data, error);
})();

// console.log(process.env.SUPABASE_URL);
// console.log(process.env.SUPABASE_ANON_KEY);
