"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const read_company_data_1 = require("../database/companies/read_company_data");
const insert_pump_data_1 = require("../database/pumps/insert_pump_data");
const read_pump_data_1 = require("../database/pumps/read_pump_data");
const secrets_1 = require("./secrets");
(async () => {
    const testCompany = await (0, read_company_data_1.getCompanyById)("1");
    console.log(testCompany);
    const p = await (0, read_pump_data_1.getPumpById)("1");
    console.log(p);
    const pump = await (0, read_pump_data_1.getPumpByMqttMsgName)("p1");
    console.log(pump);
    const testPumpPressure = {
        created_at: new Date().toISOString(),
        pressure: 1.0,
        pump_id: pump.id,
    };
    await (0, insert_pump_data_1.insertPumpPressure)(testPumpPressure);
})();
(async () => {
    const url = await (0, secrets_1.getSecretFromCloud)("SUPABASE_URL");
    const anon = await (0, secrets_1.getSecretFromCloud)("SUPABASE_ANON_KEY");
    console.log(url);
    console.log(anon);
})();
//# sourceMappingURL=test_supabase.js.map