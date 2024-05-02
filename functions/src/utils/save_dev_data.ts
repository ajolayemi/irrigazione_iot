import {httpCallableReqBody} from "../interfaces/interfaces";
import {processSectorPressure} from "./process_pressure_message";
import {processPumpFlowMessage} from "./process_pump_flow_message";
import {processPumpPressureMessage} from "./process_pump_pressure_message";
import {processPumpStatusMessage} from "./process_pump_status_message";
import {processSectorStatusMessage} from "./process_sector_status_message";

/**
 * When in development mode, this function is called to save some random data to the database
 * @param {httpCallableReqBody} body The body of the request
 */
export const saveDataWhenDev = async (body: httpCallableReqBody) => {
  if (body.isSector) {
    await processSectorStatusMessage({
      name: body.mqttMsgName,
      status: body.message,
    });
    const pubSubLikeName = `${body.mqttMsgName}_pressure`;

    if (body.msgBoolVersion) {
      await processSectorPressure([pubSubLikeName], {
        [pubSubLikeName]: Math.random(),
      });
    }
  } else if (body.isPump) {
    await processPumpStatusMessage({
      name: body.mqttMsgName,
      status: body.message,
    });

    if (body.msgBoolVersion) {
      await processPumpPressureMessage({
        IN_CH1: Math.random(),
        OUT_CH2: Math.random(),
        name: body.mqttMsgName,
      });

      await processPumpFlowMessage({
        count: 1,
        litresPerSeconds: Math.random(),
        name: body.mqttMsgName,
      });
    }
  }
};
