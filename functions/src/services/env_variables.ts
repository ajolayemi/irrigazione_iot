import dotenv = require("dotenv");
dotenv.config({path: "../../../.env"});

/**
 * Holds various env variables that are used in the project
 */
export class EnvVariables {
  /**
   * The name of the environment the app is running in
   */
  static readonly NODE_ENV: string = process.env.NODE_ENV || "";

  /**
   * The path to the google service account key file
   */
  static readonly SERVICE_ACCOUNT_KEY_FILE: string =
    process.env.SERVICE_ACCOUNT_KEY_FILE || "";
}
