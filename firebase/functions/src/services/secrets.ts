import {SecretManagerServiceClient} from "@google-cloud/secret-manager";

const client = new SecretManagerServiceClient();

/**
 * Retrieves the secret with the provided secret key from Cloud Secret Manager
 * @returns {string} The secret value
 */
export const getSecretFromCloud = async (secretKey: string): Promise<string> => {
  const [accessResponse] = await client.accessSecretVersion({
    name: `projects/968266736819/secrets/${secretKey}/versions/latest`,
  });
  const payload = accessResponse.payload?.data;
  if (payload === null || payload === undefined) {
    return '';
  }
  return payload.toString();
};

