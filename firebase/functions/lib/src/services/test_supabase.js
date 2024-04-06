"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const read_pump_data_1 = require("../database/pumps/read_pump_data");
const secrets_1 = require("./secrets");
(async () => {
    // const testCompany = await getCompanyById("3");
    // console.log(testCompany);
    const pump = await (0, read_pump_data_1.getPumpByMqttMsgName)("p2");
    console.log(pump);
})();
(async () => {
    const url = await (0, secrets_1.getSecretFromCloud)("SUPABASE_URL");
    const anon = await (0, secrets_1.getSecretFromCloud)("SUPABASE_ANON_KEY");
    console.log(url);
    console.log(anon);
})();
//# sourceMappingURL=test_supabase.js.map