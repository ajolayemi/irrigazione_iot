"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getSecretFromCloud = void 0;
const secret_manager_1 = require("@google-cloud/secret-manager");
const client = new secret_manager_1.SecretManagerServiceClient();
/**
 * Retrieves the secret with the provided secret key from Cloud Secret Manager
 * @returns {string} The secret value
 */
const getSecretFromCloud = async (secretKey) => {
    var _a;
    const [accessResponse] = await client.accessSecretVersion({
        name: `projects/968266736819/secrets/${secretKey}/versions/latest`,
    });
    const payload = (_a = accessResponse.payload) === null || _a === void 0 ? void 0 : _a.data;
    if (payload === null || payload === undefined) {
        return '';
    }
    return payload.toString();
};
exports.getSecretFromCloud = getSecretFromCloud;
//# sourceMappingURL=secrets.js.map