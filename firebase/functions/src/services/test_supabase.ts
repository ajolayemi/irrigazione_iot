import {getPumpById} from "../database/pumps/read_company_data";
import {getSecretFromCloud} from "./secrets";

(async () => {
    // const testCompany = await getCompanyById("3");
    // console.log(testCompany);
    const pump = await getPumpById("1");
    console.log(pump);
})();

(async () => {
  const url = await getSecretFromCloud("SUPABASE_URL");
  const anon = await getSecretFromCloud("SUPABASE_ANON_KEY");
  console.log(url);
  console.log(anon);
})();
