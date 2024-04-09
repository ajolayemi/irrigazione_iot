"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
require("dotenv/config");
(async () => {
    // await processSectorStatusMessage({
    //   name: "me7",
    //   status: "2",
    // });
    // const msg = `{"me7_CH1": -1.389999986, "me8_CH2": -1.399999976, "slb_CH3": -1.389999986,
    // "Api_CH4": -1.399999976, "Filter_IN": -1.399999976, "Filter_OUT": -1.399999976,
    // "Final_CH4": -2.569999933}`;
    // await processPressureMessageFromPubSub(JSON.parse(msg));
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
    // const sector = await getSectorByMqttMsgName("me8");
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
    // console.log(sector);
    // const board = await getBoardByMqttMsgName("mkr 7");
    // console.log(board);
    // await insertBoardStatusData({
    //   created_at: new Date().toISOString(),
    //   board_id: board.id,
    //   battery_level: 2.0,
    // });
    // const collector = await getCollectorByMqttMsgName("s4");
    // console.log(collector);
})();
// (async () => {
//   const url = await getSecretFromCloud("SUPABASE_URL");
//   const anon = await getSecretFromCloud("SUPABASE_ANON_KEY");
//   console.log(url);
//   console.log(anon);
// })();
//# sourceMappingURL=test_supabase.js.map