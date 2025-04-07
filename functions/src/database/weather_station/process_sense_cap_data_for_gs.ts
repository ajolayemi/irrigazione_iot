import {TablesInsert} from "../../../schemas/database.types";
import {SenseCapBatteryGs, SenseCapGs} from "../../models/sensecap_for_gs";
import {insertDataInSheet} from "../../utils/gs_utils";
import {customFormatDate} from "../../utils/helper_funcs";
import {queryWeatherStationReferencedTables} from "./read_weather_station_data";

/**
 * Process SenseCAP weather stations battery data
 * for Google Sheets
 * @param {TablesInsert<"weather_station_battery_data">} data The battery data to process
 * @return {Promise<boolean>} A promise that resolves to true if the battery data
 * was processed successfully
 */
export const processSenseCapBatteryDataForGs = async (
  data: TablesInsert<"weather_station_battery_data">
): Promise<boolean> => {
  if (!data) {
    throw new Error("No data provided");
  }

  console.log("Processing SenseCAP battery data for Google Sheets with data:");
  console.log(data);

  try {
    // Get the necessary information for processing SenseCap data
    const {station, sector, company} =
      await queryWeatherStationReferencedTables(
        data.weather_station_id.toString()
      );

    // Prepare battery data for insertion to google sheets
    const batteryDataForGs = new SenseCapBatteryGs(
      station.id,
      station.name,
      station.eui,
      company.id,
      company.name,
      sector.id,
      sector.name,
      data.battery_level,
      customFormatDate(data.created_at)
    );

    await insertDataInSheet("sensecap_battery", batteryDataForGs.getValues());
    return Promise.resolve(true);
  } catch (error) {
    throw new Error("Error processing SenseCAP battery data for Google Sheets");
  }
};

/**
 * Process SenseCAP weather stations sensor data for Google Sheets
 * @param {TablesInsert<"weather_station_measurements">} data The sensor data to process
 * @return {Promise<boolean>} A promise that resolves to true if the sensor data
 * was processed successfully
 */
export const processSenseCapSensorDataForGs = async (
  data: TablesInsert<"weather_station_measurements">
): Promise<boolean> => {
  if (!data) {
    throw new Error("No data provided");
  }

  console.log("Processing SenseCAP sensor data for Google Sheets with data:");
  console.log(data);

  try {
    // Get the necessary information for processing SenseCap data
    const {station, sector, company} =
      await queryWeatherStationReferencedTables(
        data.weather_station_id.toString()
      );

    // Prepare sensor data for insertion to google sheets
    // Prepare for data insertion into google sheets
    const dataForGs = new SenseCapGs(
      station.id,
      station.name,
      station.eui,
      company.id,
      company.name,
      station.id,
      sector.name,
      data.air_temperature,
      data.air_humidity,
      data.light_intensity,
      data.uv_index,
      data.wind_speed,
      data.rain_gauge,
      data.barometric_pressure,
      data.wind_direction_sensor,
      customFormatDate(data.created_at)
    );

    await insertDataInSheet("sensecap_weather", dataForGs.getValues());
    return Promise.resolve(true);
  } catch (error) {
    throw new Error("Error processing SenseCAP sensor data for Google Sheets");
  }
};
