import {logger} from "firebase-functions/v2";
import {TablesInsert} from "../../schemas/database.types";
import {
  insertSensorBatteryData,
  insertSensorMeasurementData,
} from "../database/sensors/insert_sensor_data";
import {getSensorByEui} from "../database/sensors/read_sensor_data";
import {
  SenseCapSensorData,
  SensorBatteryData,
  SensorMeasurementData,
} from "../interfaces/interfaces";

/**
 * Processes the data received from the SenseCAP device
 * @param data The data to process, typically a JSON object
 */
export const processSenseCapData = async (data: any): Promise<void> => {
  console.log("Processing SenseCAP data...");
  // // Get the result from the data
  // const result = data.result || data.data;

  // if (!result) {
  //   logger.error("Aborting, no result or data key found in the data");
  //   throw new Error("No result key found in the data");
  // }

  // Get the necessary data from the result
  const sensorData = getMeasurementsAndBatteryData(data);

  if (!sensorData.valid) {
    logger.error("Aborting, the sensor data is not valid");
    throw new Error("The sensor data is not valid");
  }

  // Get the sensor with the provided device eui
  const sensor = await getSensorByEui(sensorData.deviceEui);

  if (!sensor) {
    logger.error("Aborting, no sensor found with the provided device eui");
    throw new Error("No sensor found with the provided device eui");
  }

  // if battery data is available, insert battery data to database
  if (sensorData.battery) {
    const sensorBattery: TablesInsert<"sensor_battery_data"> = {
      created_at: new Date().toISOString(),
      sensor_id: sensor.id,
      battery_level: sensorData.battery["Battery(%)"],
    };
    logger.info("Saving sensor battery data to the database");
    await insertSensorBatteryData(sensorBattery);
    logger.info("Sensor battery data saved successfully");
  }

  // insert measurement data to database
  const sensorMeasurement: TablesInsert<"sensor_measurements"> =
    buildSensorMeasurementData(sensorData, sensor.id);
  logger.info("Saving sensor measurement data to the database");
  await insertSensorMeasurementData(sensorMeasurement);
  logger.info("Sensor measurement data saved successfully");
};

/**
 * Builds the sensor measurement data to insert into the database
 * @param sensorData The sensor data to build the sensor measurement data from
 * @return {TablesInsert<"sensor_measurements">} The sensor measurement data
 */
const buildSensorMeasurementData = (
  data: SenseCapSensorData,
  sensorId: number
): TablesInsert<"sensor_measurements"> => {
  const measurements: SensorMeasurementData[] = data.measurements;
  return {
    created_at: data.receivedAt,
    sensor_id: sensorId,
    air_temperature: filterSensorMeasurements(measurements, "air_temperature"),
    air_humidity: filterSensorMeasurements(measurements, "air_humidity"),
    light_intensity: filterSensorMeasurements(measurements, "light_intensity"),
    uv_index: filterSensorMeasurements(measurements, "uv_index"),
    wind_direction_sensor: filterSensorMeasurements(
      measurements,
      "wind_direction_sensor"
    ),
    wind_speed: filterSensorMeasurements(measurements, "wind_speed"),
    barometric_pressure: filterSensorMeasurements(
      measurements,
      "barometric_pressure"
    ),
    rain_gauge: filterSensorMeasurements(measurements, "rain_gauge"),
  };
};

/**
 * Filters the sensor measurements based on the key provided
 * @param measurements The measurements to filter
 * @param keyToFilter The key to filter the measurements by
 * @return {number} The filtered sensor measurements
 */
const filterSensorMeasurements = (
  measurements: SensorMeasurementData[],
  keyToFilter: string
): number => {
  const filtered = measurements.filter((measurement) =>
    measurement.type.includes(keyToFilter)
  );
  if (filtered.length === 0) {
    return 0;
  }
  return filtered[0].measurementValue;
};

/**
 * Gets the measurements and battery data from the data provided
 * @param result The raw result data to get measurements and battery data from
 * @return {SenseCapSensorData} The measurements and battery data
 */
const getMeasurementsAndBatteryData = (result: any): SenseCapSensorData => {
  const receivedAt = result.received_at;
  if (!receivedAt) {
    logger.error("Aborting, no received_at key found in the result");
    throw new Error("No received_at key found in the result");
  }

  const decodedPayload = getDecodedPayloadMsg(result);
  const deviceEui = getDeviceEui(result);

  let measurements: SensorMeasurementData[] = [];
  let battery: SensorBatteryData | undefined;

  // Loop through the decoded payload
  for (let i = 0; i < decodedPayload.length; i++) {
    const item = decodedPayload[i];
    const toMeasurement: SensorMeasurementData = item;
    if (toMeasurement.measurementId === undefined) {
      battery = item;
      continue;
    }
    const typeForDatabase = toMeasurement.type
      .split(" ")
      .join("_")
      .toLowerCase();
    measurements.push({
      measurementId: toMeasurement.measurementId,
      measurementValue: toMeasurement.measurementValue,
      type: typeForDatabase,
    });
  }

  return {
    valid: true,
    deviceEui,
    measurements,
    battery,
    receivedAt,
  };
};

/**
 * Gets the device eui from the provided data
 * @param data The data to get device eui from, typically a JSON object
 * @return {string} The device eui
 */
const getDeviceEui = (data: any): string => {
  // Get the device from the provided data
  const device = data.end_device_ids;
  if (!device) {
    logger.error("Aborting, no device key found in the data");
    throw new Error("No device key found in the data");
  }

  // Get the device eui from the device
  const deviceEui = device.dev_eui;
  if (!deviceEui) {
    logger.error("Aborting, no dev_eui key found in the device");
    throw new Error("No dev_eui key found in the device");
  }

  return deviceEui;
};

/**
 * Gets the decoded payload message from the provided data
 * @param data The data to get decoded payload from, typically a JSON object
 * @return {any} The decoded payload
 */
const getDecodedPayloadMsg = (data: any): any => {
  // Get the uplink message from the provided data
  const uplinkMessage = data.uplink_message;
  if (!uplinkMessage) {
    logger.error("Aborting, no uplink_message key found in the result");
    throw new Error("No uplink_message key found in the result");
  }

  // Get the decoded payload from the uplink message
  const decodedPayload = uplinkMessage.decoded_payload;
  if (!decodedPayload) {
    logger.error(
      "Aborting, no decoded_payload key found in the uplink_message"
    );
    throw new Error("No decoded_payload key found in the uplink_message");
  }

  // Check if the decoded payload is valid
  if (!decodedPayload.valid) {
    logger.error("Aborting, the decoded payload is not valid");
    throw new Error("The decoded payload is not valid");
  }

  // Access the message from the decoded payload
  const message = decodedPayload.messages;

  if (!message) {
    logger.error("Aborting, no message key found in the decoded payload");
    throw new Error("No message key found in the decoded payload");
  }

  return message;
};
