import {getCollectorById} from "../database/collectors/read_collector_data";
import {getCompanyById} from "../database/companies/read_company_data";
import {
  getCollectorBySectorId,
  getSectorByMqttMsgName,
} from "../database/sectors/read_sector_data";
import {HttpCallableReqBody} from "../interfaces/interfaces";
import {processSectorPressure} from "./process_pressure_message";
import {processPumpFlowMessage} from "./process_pump_flow_message";
import {processPumpPressureMessage} from "./process_pump_pressure_message";
import {processPumpStatusMessage} from "./process_pump_status_message";
import {processSectorStatusMessage} from "./process_sector_status_message";

/**
 * When in development mode, this function is called to save some random data to the database
 * @param {HttpCallableReqBody} body The body of the request
 */
export const saveDataWhenDev = async (body: HttpCallableReqBody) => {
  const now = new Date();
  if (body.isSector) {
    await processSectorStatusMessage({
      name: body.mqttMsgName,
      status: body.message,
      type: "sector_status",
    });
    const pubSubLikeName = `${body.mqttMsgName}_pressure`;

    if (body.msgBoolVersion) {
      // Get the sector
      const sector = await getSectorByMqttMsgName(body.mqttMsgName);

      if (!sector) {
        throw new Error("Sector not found");
      }

      // Get the collectorSector of this sector
      const collectorSector = await getCollectorBySectorId(
        sector.id.toString()
      );

      if (!collectorSector) {
        throw new Error("Collector connected to sector not found");
      }

      // Get the collector
      const collector = await getCollectorById(
        collectorSector.collector_id.toString()
      );

      if (!collector) {
        throw new Error("Collector not found");
      }

      // Get the company
      const company = await getCompanyById(collector.company_id.toString());

      if (!company) {
        throw new Error("Company not found");
      }

      await processSectorPressure(
        [pubSubLikeName],
        {
          [pubSubLikeName]: Math.random(),
        },
        collector,
        company,
        now
      );
    }
  } else if (body.isPump) {
    await processPumpStatusMessage({
      name: body.mqttMsgName,
      status: body.message,
      type: "pump_status",
    });

    if (body.msgBoolVersion) {
      await processPumpPressureMessage({
        IN_CH1: Math.random(),
        OUT_CH2: Math.random(),
        name: body.mqttMsgName,
      });

      await processPumpFlowMessage({
        count: 1,
        litresPerSecond: Math.random(),
        name: body.mqttMsgName,
      });
    }
  }
};
