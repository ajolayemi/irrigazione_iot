import {TablesInsert} from "../../schemas/database.types";
import {getCompanyById} from "../database/companies/read_company_data";
import {insertPumpPressure} from "../database/pumps/insert_pump_data";
import { getPumpById, getPumpByMqttMsgName} from "../database/pumps/read_pump_data";
import {getSecretFromCloud} from "./secrets";

(async () => {
    const testCompany = await getCompanyById("1");
    console.log(testCompany);

    const p = await getPumpById("1");
    console.log(p);
    const pump = await getPumpByMqttMsgName("p1");
    console.log(pump);

    const testPumpPressure: TablesInsert<"pump_pressures"> = {
      created_at: new Date().toISOString(),
      pressure: 1.0,
      pump_id: pump.id,
    };

    await insertPumpPressure(testPumpPressure)
})();

(async () => {
  const url = await getSecretFromCloud("SUPABASE_URL");
  const anon = await getSecretFromCloud("SUPABASE_ANON_KEY");
  console.log(url);
  console.log(anon);
})();
