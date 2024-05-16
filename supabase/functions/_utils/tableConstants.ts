/**
 * A class to store the names of the tables in the database
 */
export class TableNames {
  static readonly companies = "companies";
  static readonly company_users = "company_users";
  static readonly boards = "boards";
  static readonly boards_statuses = "board_statuses";
  static readonly collectors = "collectors";
  static readonly collector_sectors = "collector_sectors";
  static readonly collector_pressures = "collector_pressures";
  static readonly pumps = "pumps";
  static readonly pump_pressures = "pump_pressures";
  static readonly pump_statuses = "pump_statuses";
  static readonly species = "species";
  static readonly varieties = "varieties";
  static readonly sectors = "sectors";
  static readonly sector_pressures = "sector_pressures";
  static readonly sector_statuses = "sector_statuses";
  static readonly sector_pumps = "sector_pumps";
  static readonly pump_flows = "pump_flows";
  static readonly terminal_pressures = "terminal_pressures";
  static readonly weatherStations = "weather_stations";
  static readonly weather_station_measurements = "weather_station_measurements";
  static readonly weather_station_battery_data = "weather_station_battery_data";
}

/**
 * A class to store the names of the columns in the tables (not all columns are included)
 */
export class ColumnNames {
  static readonly pump_id_as_fkey = "pump_id";
  static readonly sector_id_as_fkey = "sector_id";
  static readonly collector_id_as_fkey = "collector_id";
  static readonly board_id_as_fkey = "board_id";
  static readonly company_id_as_fkey = "company_id";
  static readonly sensor_id_as_fkey = "sensor_id";

  static readonly columns_to_get_for_mqtt =
    "id, company_id, turn_on_command, turn_off_command";
}
