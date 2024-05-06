import * as fs from "fs";

/**
 * Reads local JSON file content and returns the parsed JSON object
 * @param {string} filePath The path to the JSON file to read
 * @return {Promise<any>} The parsed JSON object
 */
export const readJsonFile = (filePath: string): Promise<any> => {
  return new Promise((resolve, reject) => {
    fs.readFile(filePath, "utf8", (err, data) => {
      if (err) {
        reject(
          new Error(
            "An error occurred while reading the JSON file: " + err.message
          )
        );
        return;
      }
      try {
        const jsonObject = JSON.parse(data);
        resolve(jsonObject); // Resolve the promise with the JSON object
      } catch (parseErr) {
        reject(new Error("Error parsing JSON: " + parseErr));
      }
    });
  });
};
