import {getCompanyById} from "../database/read_data";
import {getSecretFromCloud} from "./secrets";

(async () => {
    const testCompany = await getCompanyById("1");
    console.log(testCompany);
})();

(async () => {
  const url = await getSecretFromCloud("SUPABASE_URL");
  const anon = await getSecretFromCloud("SUPABASE_ANON_KEY");
  console.log(url);
  console.log(anon);
})();
