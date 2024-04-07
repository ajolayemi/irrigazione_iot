"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const read_pump_data_1 = require("../database/pumps/read_pump_data");
const secrets_1 = require("./secrets");
(async () => {
    // const testCompany = await getCompanyById("1");
    // console.log(testCompany);
    const p = await (0, read_pump_data_1.getPumpById)("1");
    console.log(p);
    // const pump = await getPumpByMqttMsgName("p1");
    // console.log(pump);
    // const testPumpPressure: TablesInsert<"pump_pressures"> = {
    //   created_at: new Date().toISOString(),
    //   pressure: 1.0,
    //   pump_id: pump.id,
    // };
    // await insertPumpPressure(testPumpPressure);
    // const testPumpStatus: TablesInsert<"pump_statuses"> = {
    //   created_at: new Date().toISOString(),
    //   pump_id: p.id,
    //   status: "2",
    // };
    // await insertPumpStatus(testPumpStatus);
})();
(async () => {
    const url = await (0, secrets_1.getSecretFromCloud)("SUPABASE_URL");
    const anon = await (0, secrets_1.getSecretFromCloud)("SUPABASE_ANON_KEY");
    console.log(url);
    console.log(anon);
})();
//# sourceMappingURL=test_supabase.js.map