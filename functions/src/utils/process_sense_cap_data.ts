import {logger} from "firebase-functions/v2";
import {TablesInsert} from "../../schemas/database.types";
import {
  insertWeatherStationBatteryData,
  insertWeatherStationMeasurementData,
} from "../database/weather_station/insert_weather_station_data";
import {getWeatherStationByEui} from "../database/weather_station/read_weather_station_data";
import {
  SenseCapSensorData,
  WeatherStationBatteryData,
  WeatherStationMeasurementData,
} from "../interfaces/interfaces";
import {getDecodedPayloadMsg} from "./helper_funcs";

/**
 * Processes the data received from the SenseCAP device
 * @param {any} data The data to process, typically a JSON object
 * @return {Promise<boolean>} True if the data was successfully processed
 */
export const processSenseCapData = async (data: any): Promise<boolean> => {
  console.log("Processing SenseCAP data...");
  // // Get the result from the data
  // const result = data.result || data.data;

  // if (!result) {
  //   logger.error("Aborting, no result or data key found in the data");
  //   throw new Error("No result key found in the data");
  // }

  // Get the necessary data from the result
  const stationData = getMeasurementsAndBatteryData(data);

  if (!stationData.valid) {
    logger.error("Aborting, the provided data is not valid");
    throw new Error("The provided data is not valid");
  }

  // Get the station with the provided device eui
  const station = await getWeatherStationByEui(stationData.deviceEui);

  if (!station) {
    logger.error(
      `Aborting, no station found with the provided device eui: ${stationData.deviceEui}`
    );
    throw new Error("No station found with the provided device eui");
  }

  // if battery data is available, insert battery data to database
  if (stationData.battery) {
    const sensorBattery: TablesInsert<"weather_station_battery_data"> = {
      created_at: new Date().toISOString(),
      weather_station_id: station.id,
      battery_level: stationData.battery["Battery(%)"],
    };
    logger.info(
      `Saving battery data for station named: ${station.name} to the database`
    );
    await insertWeatherStationBatteryData(sensorBattery);
    logger.info("Station battery data saved successfully");
  }

  // insert measurement data to database
  const weatherStationMeasurement: TablesInsert<"weather_station_measurements"> =
    buildWeatherStationMeasurementData(stationData, station.id);
  logger.info(
    `Saving measurement data for station named: ${station.name} to the database`
  );
  await insertWeatherStationMeasurementData(weatherStationMeasurement);
  logger.info("Station measurement data saved successfully");

  return Promise.resolve(true);
};

/**
 * Builds the weather station measurement data to insert into the database
 * @param {SenseCapSensorData} data The weather station data to build from
 * @param {number} weatherStationId The weather station id to associate the data with
 * @return {TablesInsert<"sensor_measurements">}  The weather station measurement data
 */
const buildWeatherStationMeasurementData = (
  data: SenseCapSensorData,
  weatherStationId: number
): TablesInsert<"weather_station_measurements"> => {
  const measurements: WeatherStationMeasurementData[] = data.measurements;
  return {
    created_at: data.receivedAt,
    weather_station_id: weatherStationId,
    air_temperature: filterWeatherStationMeasurements(
      measurements,
      "air_temperature"
    ),
    air_humidity: filterWeatherStationMeasurements(
      measurements,
      "air_humidity"
    ),
    light_intensity: filterWeatherStationMeasurements(
      measurements,
      "light_intensity"
    ),
    uv_index: filterWeatherStationMeasurements(measurements, "uv_index"),
    wind_direction_sensor: filterWeatherStationMeasurements(
      measurements,
      "wind_direction_sensor"
    ),
    wind_speed: filterWeatherStationMeasurements(measurements, "wind_speed"),
    barometric_pressure: filterWeatherStationMeasurements(
      measurements,
      "barometric_pressure"
    ),
    rain_gauge: filterWeatherStationMeasurements(measurements, "rain_gauge"),
  };
};

/**
 * Filters the weather station measurements based on the key provided
 * @param {WeatherStationMeasurementData[]} measurements The measurements to filter
 * @param {string} keyToFilter The key to filter the measurements by
 * @return {number} The filtered weather station measurements
 */
const filterWeatherStationMeasurements = (
  measurements: WeatherStationMeasurementData[],
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
 * @param {any} result The raw result data to get measurements and battery data from
 * @return {SenseCapSensorData} The measurements and battery data
 */
const getMeasurementsAndBatteryData = (result: any): SenseCapSensorData => {
  const receivedAt = result.received_at;
  if (!receivedAt) {
    logger.error("Aborting, no received_at key found in the result");
    throw new Error("No received_at key found in the result");
  }

  const decodedPayload = getDecodedPayloadMsg(result, true);
  const deviceEui = getDeviceEui(result);

  const measurements: WeatherStationMeasurementData[] = [];
  let battery: WeatherStationBatteryData | undefined;

  // Loop through the decoded payload
  for (let i = 0; i < decodedPayload.length; i++) {
    const item = decodedPayload[i];
    const toMeasurement: WeatherStationMeasurementData = item;
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
 * @param {any} data The data to get device eui from, typically a JSON object
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


