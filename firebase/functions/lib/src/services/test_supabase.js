"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const read_board_data_1 = require("../database/boards/read_board_data");
const read_sector_data_1 = require("../database/sectors/read_sector_data");
const secrets_1 = require("./secrets");
(async () => {
    // const testCompany = await getCompanyById("1");
    // console.log(testCompany);
    // const p = await getPumpById("1");
    // console.log(p);
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
    const sector = await (0, read_sector_data_1.getSectorByMqttMsgName)("me8");
    // await insertSectorPressure({
    //   created_at: new Date().toISOString(),   
    //   sector_id: sector.id,
    //   pressure: 1.0,
    // });
    // await insertSectorStatus({
    //   created_at: new Date().toISOString(),
    //   sector_id: sector.id,
    //   status: "2",
    // });
    console.log(sector);
    const board = await (0, read_board_data_1.getBoardByMqttMsgName)("mkr 7");
    console.log(board);
})();
(async () => {
    const url = await (0, secrets_1.getSecretFromCloud)("SUPABASE_URL");
    const anon = await (0, secrets_1.getSecretFromCloud)("SUPABASE_ANON_KEY");
    console.log(url);
    console.log(anon);
})();
//# sourceMappingURL=test_supabase.js.map