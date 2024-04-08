import {insertSectorStatus} from "../database/sectors/insert_sector_data";
import {getSectorByMqttMsgName} from "../database/sectors/read_sector_data";
import {getSecretFromCloud} from "./secrets";

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

  const sector = await getSectorByMqttMsgName("me8");
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
})();

(async () => {
  const url = await getSecretFromCloud("SUPABASE_URL");
  const anon = await getSecretFromCloud("SUPABASE_ANON_KEY");
  console.log(url);
  console.log(anon);
})();
